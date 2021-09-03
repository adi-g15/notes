## Consensus Engine

In `validator/sawtooth_validator/core.py` with comment "Consensus Engine", there are these 6 objects:
1. consensus_thread_pool

  ```py
  consensus_thread_pool = InstrumentedThreadPoolExecutor(
            max_workers=3,
            name='Consensus')
  ```

2. consensus_dispatcher

  ```py
  consensus_dispatcher = Dispatcher()
  ```

3. consensus_service

  ```py
  consensus_service = Interconnect(
            bind_consensus,
            consensus_dispatcher,
            secured=False,
            reap=False,
            max_incoming_connections=20,
            max_future_callback_workers=10)
  ```

4. consensus_registry

  ```py
  consensus_registry = ConsensusRegistry()
  ```

5. consensus_notifier

  ```py
  consensus_notifier = ConsensusNotifier(
            consensus_service,
            consensus_registry,
            identity_signer.get_public_key().as_hex())
  ```

6. consensus_activation_observer

  ```py
  consensus_activation_observer = ConsensusActivationObserver(
            consensus_registry,
            consensus_notifier,
            settings_view_factory=SettingsViewFactory(state_view_factory))
  ```

There is also a consensus_proxy (`ConsensusProxy`; "Receives requests from the consensus engine handlers and delegates them
    to the appropriate components.")

The `ConsensusProxy::register` actually calls `ConsensusRegistry::register_engine()`.

Deep down in sawtooth sdk, here is the code that is called by `driver.start()` in [consensus code](https://github.com/hyperledger/sawtooth-devmode/blob/814e378ab32fcce9eab39c14b3774774052f521b/src/main.rs#L79-L86) - https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_driver.rs#L77-L86

That .start() function then calls `register(MessageSender,timeout,name,version,addtn_protocols)`, which creates a `ConsensusRegisterRequest` ([which is a protobuf object](https://github.com/hyperledger/sawtooth-sdk-rust/blob/06d5db9c48d296a8217b6356cec6f42a810a4dc6/protos/consensus.proto#L81-L93)), and send with the MessageSender, and this register function returns a `StartupState`(as commented in engine.rs, State provided to an engine when it is started), containing info about chain head and peers. - https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_driver.rs#L170-L210

> btw, this is how we can create connection to validator: https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_driver.rs#L69

Also, when ConsensusRegisterRequest has been sent, we wait for reply (with `validator_receiver.recv_timeout(...)`), and when received reply... [we again send an Acknowledgement...](https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_driver.rs#L297)

The .start() function [itself calls .start() on the engine itself](https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_driver.rs#L97-L104) (ie. the one we created)

The [`Engine::start()`](https://github.com/hyperledger/sawtooth-devmode/blob/814e378ab32fcce9eab39c14b3774774052f521b/src/engine.rs#L225-L385) method itself keeps looping infinitely:
```
1. Wait for an incoming message
2. Check for exit
3. Handle the meesage
4. Check the publishing
```

### DevmodeService

Each DevmodeEngine has a `service` member, which is object of class `DevmodeService`, it has these methods:

1. get_chain_head() -> Block	_(TODO: Find what all need this)_
2. get_block(block_id) -> Block	_(Likely needed by completer)_
3. initialize_block()
3. finalize_block() -> BlockID _(This calls summarize_block on service object, and we call `create_consensus(summary)`, and pass it to service.finalize_block(consensus))_

All of those methods call repective or similar method on 'service' member (it is like a wrapper on the `dyn Service` object owned by DevmodeService too)
The methods of the internal `Service` trait isn't available on either of rust or python codes

> [`ZmqService` implements that Service trait](https://github.com/hyperledger/sawtooth-sdk-rust/blob/264fb4eebe9b59f727a278b19ecb65dcec571ac9/src/consensus/zmq_service.rs#L88)...

```py
	Box::new(ZmqService::new(
                validator_sender_clone,
                Duration::from_secs(SERVICE_TIMEOUT),
            ))
```

Finally all those initialize_block, finalize_block are requests with Protobuf serialised payloads sent to the network

