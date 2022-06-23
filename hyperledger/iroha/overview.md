# Iroha

> https://iroha.readthedocs.io/en/develop/overview.html

Main diffs I see:

1. It is permissioned, 'queries' included
2. Manage digital assets
3. Pre-built commands, eg. create/transfer digital assets, negating need of cumbersome smart contracts for simple tasks

> **Consideration before writing application:** Think how it's going to interface with iroha peers

## Concepts

> https://iroha.readthedocs.io/en/develop/concepts_architecture/core_concepts.html

* Asset: Any countable commodity/value.
* Client: Any application that uses Iroha. In iroha, client interact in a client-server abstraction, any peer acts as a single server
* Command: Any intention to change state, eg. 'create role' command
* Query: A request, that does NOT change state
* Domain: Named abstraction, for grouping accounts and assets. eg. it can represent one organisation in group of multiple organisations working with iroha. _(Mereko ye namespace hi laga)_
* Peer: A node that is part of iroha's network
* Proposal: Set of transactions that have passed "stateless validation" (ie. it is well-formed, including signatures, performed in torii)
* Verified Proposal: Passed both stateless and statefull validations, but not yet commited.
* Quorum: Minimum number of signatures required to consider a transaction signed. >= 1 (default = 1, > 1 for MSTs). Each account can link extra public keys to increase own quorum number
* MST: Multi-Signature Transactions, transactions which has quorum > 1. To achieve "stateFULL validation" confirmation is required by signatories of creator account. These participants need to send same transactions with their signatures.
* Statefull validation: Performed in "Verified Proposal Creator"
* Role: Named abstraction, hold set of permissions
* Signatory: Entity that can confirm multisignatory transactions for an account. It can be attached to account via 'AddSignatory' and detached via 'RemoteSignatory'.

* Transaction: Ordered set of commands. Any non-valid command => rejected transaction

  [Transaction Statuses](https://iroha.readthedocs.io/en/develop/_images/tx_status.png)

> Similar to sawtooth, here also, we send batches of transactions.

> **Permissions** are generally role-based, except "Grantable Permissions" (https://iroha.readthedocs.io/en/develop/concepts_architecture/core_concepts.html)
>
> Grantable Permission: It is a permission that can be given to an account directly. It can perform particular action on behalf of another account. eg. a@domain1 gives b@domain2 permission to transfer it's assets, then b@domain2 can transfer assets of a@domain1 to anyone

> Blocks are recorded in files
>
> Any signable content is called payload
>
> Outside payload: signatures (signatures of peers, ed25519 public key + signature, which voted for the block during consensus round)
>
> Inside payload: height, timestamp, transactions, rejected transactions hashes (optional), previous block hash

Both users and assets are related to one of existing domains

> Accounts have a 'data' field, which is a key-value storage for any info related to the account, size limit is 255 MB

