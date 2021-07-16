# Sawtooth

Blockchain platform for building distributed ledger apps and networks.

Separates core system from the application domain.

Modular: Can chose
  * transaction rules
  * permissioning
  * consensus algo


> Distributed Ledger:
> * another term for blockchain.
> * distributes a database (ledger) of transactions
> * distributed, immutable, secure

## Separation b/w Application level & Core system

Provides smart contract abstraction allowing write contract logic in chosen language

Application can be native business logic or smart contract virtual machine. Also, both can co-exist on same blockchain
These design decisions made in transaction-processing layer, allowing multiple types of applications to exist in same instance

Each app defines custom [transaction processors].

> Example [transaction families] provided to serve as model for low-level functions

[transaction processors]: https://sawtooth.hyperledger.org/docs/core/releases/latest/glossary.html#term-transaction-processor
[transaction families]: https://sawtooth.hyperledger.org/docs/core/releases/latest/glossary.html#term-transaction-family

#### Private Networks with Sawtooth permissioning features

> The blockchain stores the settings that specify the permissions, such as roles and identities, so that all participants in the network can access this info

## Parallel Transaction Execution

Serial transactions are generally used in order to guarantee consistentn ordering at each node.
Instead, Sawtooth includes advances **parallel sheduler** that splits transactions into parallel flows.

> Based on locations (in state) which are accesseed by a transaction, it isolates the execution of transactions from one another while maintaining contextual changes.



