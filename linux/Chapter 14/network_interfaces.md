# Network Interfaces

Network Interfaces are a **connection channel between a device and the network**.

Physically, they can proceed through a NIC (network interface card), or can be abstractly implemented as software.
We can have multiple interfaces operating at once.
Specific interfaces can be brought up (activate) or down (deactivate) at any time.

> `ip` is newer than `ifconfig` and `route`. Some newer distros don't even have the older package installed.

## Utilities

> Skipped ip, route

### traceroute

traceroute is used to inspect the route which the data packet takes to reach the destination host, which makes it quite useful for troubleshooting network delays and errors. By using traceroute, you can isolate connectivity issues between hops, which helps resolve them faster.

To print the route taken by the packet to reach the network host, at the command prompt, type traceroute \<address\>.

* ethtool -> Queries network interfaces and can also set various parameters such as the speed
* netstat -> Displays all active connections and routing tables. Useful for monitoring performance and troubleshooting
* nmap 	Scans open ports on a network. Important for security analysis. For eg. this lists open port at an IP - `sudo nmap -Sp 10.0.2.15/24`
* tcpdump -> Dumps network traffic for analysis
* iptraf -> Monitors network traffic in text mode
* mtr -> Combines functionality of ping and traceroute and gives a continuously updated display
* dig -> Tests DNS workings. A good replacement for host and nslookup

