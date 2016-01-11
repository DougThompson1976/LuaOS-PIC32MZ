# net module

This module contains functions for accessing a TCP/IP network from the whitecat
and manage the network interfaces. The whitecat needs an specific connectivity 
shield in order to use this module.

Interfaces are identified by it's name, and can be one of this:

* en: ethernet interface
* gprs: gprs interface
* wf: wifi interface (not supported in this release)

For use this module it's mandatory to do this initialization sequence:

* setup the interface using net.setup function
* start the interface using net.start function

Once all network interaction is done you can stop the interface using net.stop 
function. This is a good practice for battery-friendly applications.


## net.setup(interface, apn, pin) - for GPRS interface

Setup the gprs interface.

Arguments:

* interface: interface name, use gprs for setup the gprs interface.
* apn: apn name.
* pin: SIM's pin.


```lua
-- Setup the GPRS interface for vodafone m2m, with a SIM card with pin 1234
net.setup("gprs", "m2m.vodafone.es", "1234")
```


## net.start(interface)

Start the network interface. It's mandatory to setup the interface before using 
net.setup function.

Arguments:

* interface: interface name

Returns:

* success: true or false
* error: error message, if not success


```lua
-- Start ethernet interface

net.start("en")
```


## net.stop(interface)

Stop the network interface.

Arguments:

* interface: interface name

Returns:

* success: true or false
* error: error message, if not success


```lua
-- Stop ethernet interface

net.stop("en")
```


## net.stat()

Show the status of each network interface.

Returns: nothing

```lua
net.stat()

en: mac address 00:1e:c0:c2:15:44
        ip address 192.168.18.39 netmask 255.255.255.0
        gw address 192.168.18.1
        dns1 address 8.8.8.8
        dns2 address 4.4.4.4
```


## ip = net.packip(ip1, ip2, ip3, ip4)

Returns packet representation of an IPv4 address that can be used with all 
net's module functions that require an IP address as argument. The IP address is
 provided from the 4 elements that make up an IPv4 address: ip1.ip2.ip3.ip4

Arguments:

* ip1: the first part of the ip address
* ip2: the second part of the ip address
* ip3: the third part of the ip address
* ip4: the fourth part of the ip address

Returns: an integer that encodes the IP address.

```lua
localhost = net.packip(127,0,0,1)
print(localhost)
16777343
```


## ip = net.packip("ip")

Returns a packet representation of an IPv4 address that can be used with all 
net's module functions that require an IP address as argument. The IP address is
 provided as the IPv4 canonical representation.

Arguments:

* ip: the IP addres string in  IPv4 canonical representation

Returns: an integer that encodes the IP address.

```lua
localhost = net.packip("127.0.0.1")
print(localhost)
16777343
```


## ip1, ip2, ip3, ip4 = net.unpackip(ip, '*n')

Returns an unpacked representation of an IPv4 address packed by net.packip 
function. The unpacket representation is provided by the 4 elements that make 
up an IPv4 address.

Arguments:

* ip: the packet IP address

Returns:

* ip1: the first part of the ip address
* ip2: the second part of the ip address
* ip3: the third part of the ip address
* ip4: the fourth part of the ip address

```lua
localhost = net.packip("127.0.0.1")
ip1, ip2, ip3, ip4 = net.unpackip(localhost, '*n')
print(ip1.." "..ip2.." "..ip3.." "..ip4)
127 0 0 1
```


## ip = net.unpackip(ip, '*s')

Returns an unpacked representation of an IPv4 address packed by net.packip 
function. The IP unpacket representation is provided as the IPv4 canonical 
representation.

Arguments:

* ip: the packet IP address

Returns: the IP addres string in  IPv4 canonical representation

```lua
localhost = net.packip("127.0.0.1")
ip = net.unpackip(localhost, '*s')
print(ip)
127.0.0.1
```


## ip = net.lookup(hostname)

Makes a DNS lookup.

Arguments:

* hostname: the hostname to make the lookup

Returns: the packet IP of the hostname.


```lua
ip = net.lookup("whitecat.org")
print(net.unpackip(ip, "*s"))
207.148.248.143
```