# Consensus Engine

## Overview

This doc uses the [sawtooth sdk](https://github.com/hyperledger/sawtooth-sdk-rust/) to create a custom consensus engine (basic).

> Note: `...` anywhere in code blocks mean that part is covered in earlier section, for eg. instead of writing start(update,service,blah,kya,kuchh) we write start(...) in 2nd and further occurences

On the above level, there are these two steps:
1. Code (your consensus Engine)
2. Start validator with changed values of `sawtooth.consensus.algorithm.name`, `sawtooth.consensus.algorithm.version` (and other values which are specific to your consensus engine) on-chain settings

  ie. you may change the entrypoint for the validator container like so:
  ```sh
  "bash -c \"\
        sawadm keygen && \
        sawtooth keygen my_key && \
        sawset genesis -k /root/.sawtooth/keys/my_key.priv && \
        sawset proposal create \
          -k /root/.sawtooth/keys/my_key.priv \
          sawtooth.consensus.algorithm.name=**YOUR_CUSTOM_ENGINE_NAME** \
          sawtooth.consensus.algorithm.version=**YOUR_CUSTOM_ENGINE_VERSION** \
	  sawtooth.consensus.algorithm.MYCUSTOMKEY=**SOME_VALUE_YOUR_CONSENSUS_NEEDS_OR_NO_NEED_FOR_THIS_LINE** \
          -o config.batch && \
        sawadm genesis config-genesis.batch config.batch && \
        sawtooth-validator -v \
          --endpoint tcp://validator:8800 \
          --bind component:tcp://eth0:4004 \
          --bind network:tcp://eth0:8800 \
          --bind consensus:tcp://eth0:5050 \
        \""
  ```
3. Start your custom engine (**be sure that some consensus is not already running, read [changing engines](https://sawtooth.hyperledger.org/docs/core/releases/latest/architecture/journal.html#the-consensus-interface) for more info**), the logs should show "Registered transaction processor or something similar"

<div align="center"><img src="registered_ss.png" alt="Screenshot: Engine_registered" /></div>

> Note:
> Here we are considering the [Sawtooth Devmode](github.com/hyperledger/sawtooth-devmode/) consensus engine for reference, you may like to see it's specific logic (should be easy to understand :)

## Custom Consensus Engine

Generally we start with these two files (you may do it in more or less, depending on logic):
1. main.rs
2. engine.rs

### main.rs

In this you create a ZMQ-based consensus engine driver, like so:

```rs
use sawtooth_sdk::consensus::zmq_driver;

...

let (driver, _stop) = zmq_driver::ZmqDriver::new();
```

> `_stop` is a handle for stopping it (you may leave that for now), and it provides a `.stop()` method to do the same

Then, considering you will be naming your Consensus Engine as `CustomEngine`, we register and start the consensus engine by calling .start() on the driver, passing your consensus engine object

```rs
mod engine;	// declare engine.rs as a module
use engine::CustomEngine;

...

match driver.start("tcp://localhost:5050", CustomEngine::new()) {
        Ok(()) => (),
        Err(e) => {
            _stop.stop();
            panic!("{}",e);
        }
    }
```

> `tcp://localhost:5050` is the endpoint, you may take it as input from user, [see devmode engine main.rs for the same](https://github.com/hyperledger/sawtooth-devmode/blob/814e378ab32fcce9eab39c14b3774774052f521b/src/main.rs#L38-L50)

That's all for the main.rs file 😃, now we have to implement `CustomEngine` class/struct, let's do that **in `engine.rs`**

```rs
pub struct CustomEngine {}

impl CustomEngine {
    pub fn new() -> CustomEngine {
        CustomEngine {}
    }
}
```

If you try to run the code like this only, it will tell you that **We need to implement sawtooth_sdk::consensus::engine::Engine for each consensus engine**

We need to implement four functions:
1. `start(self,updates,service,startup_state)`: This is the function that generally will go into an infinite 
2. `version()` -> Return your engine's version, for eg. "0.1"
3. `name()` -> Return your engine's name, for eg. "CustomEngine"
4. `additional_protocols()`

```rs
use sawtooth_sdk::consensus::engine::{Engine,StartupState,Update,Error};
use sawtooth_sdk::consensus::service::Service;
use std::sync::mpsc::Receiver;

// ...

impl Engine for CustomEngine {
    // start() function yet to implement

    fn version(&self) -> String {
        "0.1".to_string()
    }

    fn name(&self) -> String {
        "CustomEngine".to_string()
    }

    fn additional_protocols(&self) -> Vec<(String,String)> {
        vec![]
    }
}
```

To get it to **just work**, we return Ok(()) from start function (basically
nothing):

```rs
// impl Engine for CustomEngine {
    fn start(
        &mut self,
        updates: Receiver<Update>,
        service: Box<dyn Service>,
        startup_state: StartupState) -> Result<(), Error> {

	Ok(())
    }
// ...
```

It isn't enough, though, if you now run it, it will run without any errors, and also show a "Consensus Engine registered"

### Getting to base minimum logic

Now, we are going to use the arguments we have received. **Inside `start` function**:

```rust
fn start(
...
) -> Result<(), Error> {
    service.initialize_block(None).expect("Failed to initialize_block");

    loop {	// we do an infinite loop, until we get Shutdown request
	let incoming_message = updates.recv_timeout(
				    time::Duration::from_millis(10)
				    );
	
	match incoming_message {
	    Ok(update) => {
		// TODO: We will handle update in next step
	    },
	    Err(RecvTimeoutError::Disconnected) => {
		println!("Disconnected from validator");
		break;	// end the infinte loop
	    },
	    Err(RecvTimeoutError::Timeout) => { /*ignoring for this doc*/ }
	}
    }
    
    Ok(())
}
```

### Handling updates

If `incoming_message` (in code in prev section) is Ok, it contains `update`,
which is one of the following:

* Update::PeerConnected
* Update::PeerDisconnected
* Update::PeerMessage
* Update::BlockNew
* Update::BlockValid
* Update::BlockInvalid
* Update::BlockCommit
* Update::Shutdown

You can (and should) handle all of them, though for this example, we handle 
1. **BlockNew** (Received a block, also sent for genesis block)
2. **BlockValid** (a block has been validated to be correct, here is where we
   may increase the chain, or create a new fork, or maybe ignore this block)
3. **BlockCommit** (chain head has been updated, start working on new block)
4. **PeerMessage** (sending and receiving acknowledgement for blocks, and other messages)
5. **Shutdown** (shutdown request)

So, **inside the Ok(update) => {} block**, we can add these:

```rust
... // match statement and everything previous to that
Ok(update) => {
    Update::BlockNew(block) => {
	// 8 bytes with 0 block id means there is no previous block, ie. 
	// **current block is genesis block**
	if block.previous_id == [0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] {
	    // Check consensus, to check if it passes or fails
	    if block.payload == create_consensus(block.summary) {
		// Passed consensus check
		service.check_block(block.block_id);
	    } else {
		// Failed consensus check
		service.fail_block(block.block_id);
	    }
	}
    }
    ... others implemented later on
}
...

```

> In above code, you see that `create_consensus` function. In this what we do is
> just _append_ extra bytes to block summary and return it.
> The extra bytes are specific to your consensus engine, for example, Devmode
> engine returns block.summary + _bytes(_"Devmode"_)_ 
>
> For our custom engine, add this somewhere in engine.rs
> ```rust
> fn create_consensus(block_summary: &[u8]) -> Vec<u8> {
>     let mut consensus: Vec<u8> = Vec::from(&b"CustomDevmode"[..]);
>     consensus.extend_from_slice(block_summary);	// append block summary
>     consensus
> }
> ```

Now back to implementing other Updates,

```rust
... implemented till Update::BlockNew
    Update::BlockValid(block_id) => {
	// Get block from service, since we will need the complete block to verify
	let block = service.get_blocks(vec![block_id.clone()]).expect("Failed to
	get block").remove(&block_id).unwrap();
	// TODO: Send block received

	let chain_head = service.get_chain_head().expect("Failed to get chain
	head");
    }
```

// TODO

## Internals



