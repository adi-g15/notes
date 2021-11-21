# How DHCP works

* Upon boot up, PC requests an IP configuration sends a DHCP discovery packet
  * Discovery packet sent to the broadcast address 255.255.255.255:67 (UDP port
    67)

* DHCP server receives it, and responds with an offer packet
  * Offer packet is sent to the MAC address of computer using UDP port 68

* Computer receives the offer packet, and returns a request packet (requesting
  proper IP configuration) to the DHCP server

* DHCP server receives request packet, responds with an acknowledgement packet,
  **which contains the required IP configuration information**

* Computer receives the acknowledgement packet, and changes its IP configuration

