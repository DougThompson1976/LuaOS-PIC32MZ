# CAN module

This module contains functions for accessing the Controller Area Network  
(CAN) module. Although the PIC32MZ has 2 CAN modules, the whitecat has 1 
on-board CAN transceiver, so only 1 CAN module can be used. For applications 
that need more CAN modules there are specific shields for the whitecat.

CAN modules are identified by the constants can.CAN1 and can.CAN2.


## real speed = can.setup(id, speed)

Setup the CAN module.

Arguments:

* id: CAN module identifier. Use can.CAN1 for use the on-board can module.
* speed: speed for the CAN bus expressed in kilohertz.

Returns: the real CAN bus speed.

```lua
-- Setup the on-board CAN at 250 kilohertz
can.setup(can.CAN1, 250)
```


## can.send(id, canid, id type, len, data)

Send a CAN data frame over the CAN bus.

Arguments:

* id: CAN module identifier.
* canid: CAN identifier.
* id type: CAN identifier type, can be either can.STD for a 11-bit identifier. 
and can.EXT for a 29-bit identifier.
* len: length of the data frame (maximum of 8 byte according to CAN specs).
* data: data to send.

Regturns: nothing.


```lua
-- Setup the on-board CAN at 250 kilohertz
can.setup(can.CAN1, 250)

-- Send a data frame with standard identifier 100 and contents 1234
can.send(can.CAN1, 100, can.STD, 4, "1234")
```


## canid, id type, len, data = can.receive(id)

Receive a CAN data frame from the CAN bus. It's the programmer's responsibility 
to filter the received can messages, so filter capabilities are not support for 
in current release.

Arguments:

* id: CAN module identifier.

Returns:

* canid: received CAN identifier.
* id type: received CAN identifier type.
* len: length of the received data.
* data: received data.


```lua
-- Setup the on-board CAN at 250 kilohertz
can.setup(can.CAN1, 250)

-- Receive data frame
canid, type, len, data = can.recv(can.CAN1)
print("canid: "..canid..", type: "..type..", len: "..len..", data : "..data)
```

