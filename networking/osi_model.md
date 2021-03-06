# OSI Model

> https://www.youtube.com/watch?v=vv4y_uOneC0

OSI Model Layers (Highest to Lowest):
  * Application
  * Presentation -> converts charcters to binary + compress +
    encryption/decryption
  * Session -> APIs, authentication + authorisation
  * Transport -> (UDP,TCP) Dividing/Combining into packets
  * Network -> (IP) Logical Addressing + Routing
  * Data Link -> (MAC) Physical Addressing
  * Physical

Each layer is a package of **protocols**, so Application layer doesn't include browser etc apps like Firefox, instead it includes Application Layer Protocols

## Application Layer

Used by user-space network applications, like Firefox, to access the _internet_, using protocls provided by this layer, such as
  * HTTP/S
  * FTP
  * NFS
  * FMTP
  * DHCP
  * SNMP
  * TELNET
  * POP3
  * IRC
  * NNTP

