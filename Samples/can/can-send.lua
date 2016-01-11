-- WHITECAT sample code
--
-- Sample: can-send.lua
--

-- Module to use
canm = can.CAN1
can.setup(canm, 250)

while true do
    can.send(canm, 100, can.STD, "1234")
end