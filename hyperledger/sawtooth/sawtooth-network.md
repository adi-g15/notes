# Sawtooth Network

> sawtooth.hyperledger.org/docs/core/releases/latest/architecture/validator_network.html

The network layer responsible for communication b/w validators on the network, including:
* Performing initial connectivity
  > When started, validator begins listening on specified interface & port for incoming connections
* Peer discovery
* Message handling
  > Upon connection & peering, validators exchange messages with others, based on rules of [Gossip (aka epidemic) protocol](https://en.wikipedia.org/wiki/Gossip_protocol) (from Wikipedia: the protocol itself is generally implemented with random "peer selection", with given frequency, picking another machine at random, and share any message)

> Design goal: It should be self-contained, it doesn't need payload info, nor should application should need its internal details.

## Services

[ZeroMQ](http://zeromq.org/) gives good flexibility in both how to connect and underlying transport layer (IPv4,IPv6,etc)

Sawtooth adopts [ZeroMQ async client/server pattern](https://zguide.zeromq.org/docs/chapter3/#The-Asynchronous-Client-Server-Pattern), consisting of ROUTER socket on server side (listening on provided endpoint), with connected ZeroMQ DEALER socket on client side.

> For each request, server sends 0 or replies. Client/Server can send multiple request/response without waiting for reply

![Multiple DEALER to ROUTER socket pattern](sawtooth.hyperledger.org/docs/core/releases/latest/_images/multiple_dealer_to_router.svg)

### Connection states

* Unconnected
* Connected - Required for peering
* Peered - A bidirectional relation, forming base case for application-level message passing (gossip)

> Ping messages allow for keep-alive between ROUTER and DEALER sockets

## Transmission Methods

* `BROADCAST(MSG)` - transmit message to whole network following 'gossipy' pattern (doesn' guarantee 100% delivery to whole network, but based on gossip, nearly complete discovery likely)
* `SEND(NODE,MSG)` - Send over a bidirectional ZeroMQ connection
* `REQUEST(MSG)` - Special type of broadcast message, that can be examined and replied to, rather than forwarded. Intent is to construct message payload, that is examined by a special request handler and replied to, rather than forwarded on to connected peers.

# Peer Discovery

A bidirectional peering via a neighbor-of-neighbors approach gives reliable connectivity (messages delivered to all nodes > 99% of the time based on random construction of the network).

![Bidirection peering](sawtooth.hyperledger.org/docs/core/releases/latest/_images/bidirectional_peering.svg)

## REST API

> sawtooth.hyperledger.org/docs/core/releases/latest/architecture/rest_api.html

A simple interface for clients interact with validator, with simple HTTP/JSON.

The validator & TPs use ZMQ/Protobuf interface which is more robust, efficient, complicated, so clients also have the option to use ZMQ/Protobuf interface

It treasts the validator as a _Black box_, simply submitting transactions & fetching results

