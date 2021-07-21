# Transactions & Batches

Modifications to state performed by creating and applying transactions.

A client creates a transaction and submits it to the validator, which applies the transaction.

Transactions always wrapped inside of a batch, all are commited to state together or not at all. Thus, **batches are the atomic unit of state change**

> Transactions and batches serialized using Protocol buffers

> Transactions from multiple transaction families can also be batched together , furthur encouraging reuse of transaction families.

> Transactions and batches can be signed by different keys
> For eg. browser can sign a transaction, and server-side component can add transactions, create batch and sign the batch.
> Thus, enables aggregation of transactions from multiple transactors, into an atomic operation (batch).

