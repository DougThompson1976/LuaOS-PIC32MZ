-- WHITECAT sample code
--
-- Sample: can-recv.lua
--

-- Module to use
canm = can.CAN1
can.setup(canm, 250)
i = 0
while (i < 3000) do
    i = i + 1
	id, type, len, msg = can.recv(canm)

    -- This is only for test purposes
    -- Output to console can cause internal queue overflows
    print("id "..id..", type "..type..": "..msg..", len "..len)
end