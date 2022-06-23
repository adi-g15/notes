## Insides

> https://iroha.readthedocs.io/en/develop/concepts_architecture/architecture.html

**Torii** (⛩) is the entry point for shrines in Japan, as well as to Iroha :)

Each node has its own ordering service (gRPC server that receives messages from other peers and combines several transactions that have been passsed stateless validation into a proposal)

Simulator = VPC + Block Creator;   (Verified Proposal Creator does the statefull validation)


