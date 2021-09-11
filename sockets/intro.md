## What ?

> https://github.com/adi-g15/sockets_c

* Sockets are low level endpoint used for processing info across a network.

* Common networking protocols like HTTP, FTP rely on sockets underneath to make connections

> Anything that interacts with the network can be built using sockets

## Client Socket workflow

```
socket() -> connect() -> recv()
```

## Server Socket workflow

```
socket() -> bind() -> listen() -> accept()
```

> `accept()` allows us to accept a connection, then we can use `send()` or `recv()` data to the other sockets it has connected to

