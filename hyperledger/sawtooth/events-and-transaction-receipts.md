## Events and Transaction Receipts

> sawtooth.hyperledger.org/docs/core/releases/latest/architecture/events_and_transactions_receipts.html

Sawtooth supports creating & blocking events.

We (apps) can:
* Subscribe to chain related events
* Subscribe to application specific events, defined by transaction family

Read more on the details on the [link](sawtooth.hyperledger.org/docs/core/releases/latest/architecture/events_and_transactions_receipts.html)

* Transaction Receipts: info related to execution of transaction, that shouldn't be stored in state ->
  * Whether transaction valid
  * State change due to it
  * Events of interest that occured during it's execution
  > Can also provide with info about it's execution w/o re-executing it

