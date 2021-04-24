## Wired and Wireless Connections

**Wired connections**:  usually _do not_ require complicated or manual configuration. The hardware interface and signal presence are automatically detected, and then Network Manager sets the actual network settings via **D**ynamic **H**ost **C**onfiguration **P**rotocol (DHCP).

For **static** configurations that do not use DHCP, manual setup can also be done easily through Network Manager. You can also change the Ethernet **M**edia **A**ccess **C**ontrol (MAC) address (if the hardware supports it).

> The MAC address is a unique hexadecimal number of your network card.


**Network Manager** also supports many VPN technologies, such as
  * native IPSec
  * Cisco OpenConnect (via either the Cisco client or a native open source client)
  * Microsoft PPTP
  * OpenVPN.

You might get support for VPN as a separate package from your distributor.
