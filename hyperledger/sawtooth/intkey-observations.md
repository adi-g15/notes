# General Observation

validator ek component hai node ka jis se some 4004 port pe transaction processors attach ho sakte hai

To pehle, transaction processor ko validator se connect hona hai, to request bhejega us port pe

# Rust code observation

1. Transaction processor register karne ka part hamko nhi karna hai, ie. no rest api call to make, it is through given functions in sawtooth-sdk

2. It was basically divided into two:
  * main.rs - Just creates a CLI app, with the arguments "-v", "-C", and then register a **handler** through `TransactionProcessor::add_handler` then `TransactionProcessor::start()`
  * handler.rs - Has the code to how to respond to requests... more in next part

## Handler

Handler simply TransactionHandler class ko inherit karke kuchh functions implement karta hai, some of them...

* family_name() -> For eg. intkey ke liye ye "intkey" hai
* family_versions() -> Ek array rehta hai version strings ka
* namespaces() -> prefix string hai, used for address (jaisa ki intkey ke doc me tha, address calculation part)
* apply() -> **Most important**, this is likely the call that 'applies' the payload/data/action with the request
  Recieves two arguments: request (`TpProcessRequest`), context (`TransactionContext`)
  `request.get_payload()` se payload extract kar sakte hai request se
  Then, the rest part is basically yes or no to apply or not
  Returns `Result<(), ApplyError>`

## Client side

Client side basically APIs se chalta hai
Create your CLI, implement functions in a class or whatever

The important parts are:
* `_get_status()` -> To get batch statuses
* `_get_prefix()` -> Wahi pichhla section wala
* `_get_address()` -> The address according to the Address Calculation, Intkey docs

* `_send_request()` -> The part that **directly** interacts with the REST API

* `_send_transaction()` -> **@adi Valuable** This is the kernel, considering the send_request was just the Kernel APIs/drivers
  Idhar kaam padta hai serialisation, deserialisation ka
  Idhar deal with the TransactionHeader and other types, construct the Transaction (also a class, instantiate an object with **Header**, **Payload**, **HeaderSignature**)... create the batch request, then use the `_send_request` calls to actually pass on this data to the API

  Then... rest is the story I am writing... back to the beginning... then the request goes to the validator, which passed it onto the TP, which has that apply() function to make the decision... aur phir Done :D

    Idhar kaam padta hai serialisation, deserialisation ka
