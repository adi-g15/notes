# main.rs

The main file (at validator/src/main.rs) does these:
1. Get a Python GIL
2. Start a logger (& metrics)
3. imports `sawtooth_validator.server.cli` and calls it's `main` function

> **GIL**
>
> _Global Interpreter Lock_: It is a mechanism in interpreters to synchronise threads so that only one native thread executes at a time
>
> Examples, CPython has GILo

```rust
// Calling the python main function...
use cpython::Python;

//...
let cli = Python::acquire_gil().python();
py.import("sawtooth_validator.server.cli")?.call(py, "main", (...args...), None)
//...
```

So the rust code transfers control to the python code main function

## main.py

This is the python file, where the control is transferred

Does these:
* Start an `InfluxReporter` (using metrics registry)
* Starts an `Validator` _(server.core.Validator)_ -
  * Uses a `ValidatorConfig` that specifies bind component, bind network, bind consensus, and networking things
  * Apart from ValidatorConfig it adds the thread pools thing
  * See the `validator::start()`, that's the primary logic ()

It imports **some** modules, such as the `MetricsRegistry`, `InfluxReporter`, and **helpers** (such as server.core.Validator, journal, config)... so still it doesn't do everything, i mean the major parts are still different...

## `Validator`

It imports these:
* concurrent.notifier
* consensus.{proxy,registry}
* database.lmdb
* journal.{block_{validator,sender,store,manager}, completer, responder, journal, receipt_store}
* networking.{dispatch, interconnect}
* state.{batch_tracker, merkle.MerkelDatabase, settings_{view,cache}, {identity,state}_view}
* gossip.{gossip, permission_verifier, identity_observer}
* server.{events.broadcaster, {network,component,consensus}_handlers}

In constructor, creates 3 lmdb databases... for state (merkle tree), transaction receipts, and blocks. It also set up these:
* 3 LMDB databases, BlockManager
  * Global Store Database & Factory
  * Receipt Store
  * Block Store
* Thread pools (component, network, client, signature)
* Dispatchers (component, network)
* Services (component, network)
* Transaction Execution Platform
  * BatchTracker
  * SettingsCache
  * EventBroadcaster
* Consensus Engine
  * InstrumentedThreadPoolExecutor
  * Dispatcher
  * Interconnect
  * ConsensusRegistry
  * ConsensusNotifier
  * ConsensusActivationObserver
* P2P Network
  * Gossip
  * Completer
  * BroadcastBlockSender
  * IdentityViewFactory
  * IdentityCache
* Permissioning
  * PermissionVerifier
  * IdentityObserver, SettingsObserver
* Journal
* Register Message Handlers (component, network)

## `Validator::start()`

The start method calls start on already initialised objects, in the following order:
1. Component Dispatcher & Server
2. Journal
3. Consensus Dispatcher & Service
4. Network Dispatcher & Service
5. Gossip
6. Completer.set_on_batch_received(journal.submit_batch)
7. ... wait till killed (signal.signal(SIGTERM) .wait())

