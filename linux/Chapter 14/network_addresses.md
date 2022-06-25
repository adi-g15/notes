# IP

> To get your IP just use `ip --brief a`

Devices attached to a network have at least one unique network address id known as the IP address.

Exchanging information across the network requires using streams of small packets. These packets contain data buffers, together with headers which contain info about where the packet is going and coming from, and where it fits in the sequence of packets that constitute the stream.

> Networking protocols and software are rather complicated due to the diversity of machines and operating systems they must deal with, and supporting old standards.

# IPv4 & IPv6

These are two different types of IP addresses available.

* IPv4 uses 32-bits for addresses; there are _only_ 4.3 billion unique addresses available.
* IPv6 uses 128-bit for addresses; this allows for 3.4 * 10^38 unique addresses.

> However the protocols dont always interoperate well

> One reason IPv4 hasn't disappeared is there are ways to effectively make many more addresses available using methods such as **NAT** (Network Address Translation).
>
> NAT enables sharing one IP address among many locally connected computers, each of which has a unique address only seen on the local network.
>
> For eg. if you have a router hooked to your Internet Provider, it gives you **one externally visible address**, but issues each device in your home an individually local address.

## Decoding IPv4 addresses

A 32-bit IPv4 address divided into four octets (bytes)

> NID -> Network address (Netword ID)
> HID -> Host address (Host ID)

Addresses divided into five classes -
* A -> 1bit NID + 3bit HID
* B -> 2bit NID + 2bit HID
* C -> 3bit NID + 1bit HID
* D -> Multicast addresses (info is broadcasted to multiple computers simultaneously)
* E -> Reserved for future use

### Class A network addresses

First bit is always set to 0. And 00000000 & 11111111 are reserved.
So only 126 Class A network numbers. (with huge number of hosts possible for each, 1.67 Crore unique hosts)

As the use of internet expanded, Class B & Class C were added.

### Class B network addresses

Starts with binary 10.

### Class C network addresses

Starts with binary 110

