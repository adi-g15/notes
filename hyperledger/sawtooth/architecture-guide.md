# Architecture

> sawtooth.hyperledger.org/docs/core/releases/latest/architecture.html

![architecture](arch-sawtooth-overview.svg)

## Global State

The ability to ensure a consistent copy of data, amongs nodes in Byzantine consensus, is one of the core strenghts of blockchain.

Sawtooth represents state for all transaction families in **a single instance of a Merkle-Radix tree on each validator**.

Block validation on each validator ensures that same transactions have same state transitions, and same resulting data for all nodes.

> The state is split into _namespaces_ allowing flexibility for transaction family authors to define, share/reuse global state data b/w transaction processors

### Merkle-Radix Tree

> The tree is Merkle tree _because_

#### Merkle Hashes


