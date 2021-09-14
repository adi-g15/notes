# Consensus Engine

## Overview

This doc uses the [sawtooth sdk](https://github.com/hyperledger/sawtooth-sdk-javascript/) to create a custom consensus engine (basic).

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
1. main.js
2. engine.js

### main.js

In this you create a ZMQ-based consensus engine driver, like so:

```rs
from sawtooth_sdk.consensus.zmq_driver import ZmqDriver
(driver, _stop) = ZmqDriver();
```

> `_stop` is a handle for stopping it (you may leave that for now), and it provides a `.stop()` method to do the same

Then, considering you will be naming your Consensus Engine as `CustomEngine`, we register and start the consensus engine by calling .start() on the driver, passing your consensus engine object

```rs
from engine import CustomEngine		# imports from engine.js file
driver.start("tcp://localhost:5050", CustomEngine());
```

> `tcp://localhost:5050` is the endpoint, you may take it as input from user, [see devmode engine main.js for the same](https://github.com/hyperledger/sawtooth-devmode/blob/814e378ab32fcce9eab39c14b3774774052f521b/src/main.js#L38-L50)

That's all for the main.js file 😃, now we have to implement `CustomEngine` class/struct, let's do that in `engine.js`

```rs
pub struct CustomEngine {}

impl CustomEngine {
    pub function new() -> CustomEngine {
        CustomEngine {}
    }
}
```

If you try to run the code like this only, it will tell you that **We need to implement sawtooth_sdk.consensus.engine.Engine for each consensus engine**

We need to implement four functions:
1. `start(self,updates,service,startup_state)`: This is the function that generally will go into an infinite 
2. `version()` -> Return your engine's version, for eg. "0.1"
3. `name()` -> Return your engine's name, for eg. "CustomEngine"
4. `additional_protocols()`

```rs
import Engine,StartupState,Update,Error from sawtooth_sdk.consensus.engine;
import Service from sawtooth_sdk.consensus.service;

// ...
// TODO: Implementing traits/abstract class in javascript
impl Engine for CustomEngine {
    // start() function yet to implement

    function version(&self) -> String {
        "0.1".to_string()
    }

    function name(&self) -> String {
        "CustomEngine".to_string()
    }

    function additional_protocols(&self) -> Vec<(String,String)> {
        vec![]
    }
}
```

To get it to **just work**, we return Ok(()) from start function (basically
nothing):

```rs
// impl Engine for CustomEngine {
    function start(self,updates,service,startup_state):
	return
// ...
```

It isn't enough, though, if you now run it, it will run without any errors, and also show a "Consensus Engine registered"

Adding some logic:

# TODO

## Internals



