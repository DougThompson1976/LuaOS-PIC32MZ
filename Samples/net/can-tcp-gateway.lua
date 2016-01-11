-- WHITECAT sample code
--
-- Sample: can-tcp-gateway.lua
--
-- Description:
--   CAN 2 TCP gateway on port 80

can.setup(can.CAN1, 250000)
socket = net.socket(net.SOCK_STREAM)                              

client, ip, err = net.accept(socket, 80, 10)
if err == net.ERR_OK then
   print("New conection at "..net.unpackip( ip, '*s' ))

    net.send(client, "CAN2TCP gateway\n")
    net.send(client, "Dumping ...\n")

	while true do
        packet = can.rawrecv(can.CAN1)
        net.send(client, packet)
        net.send(client, "\n")
	end
end

net.close(client) 
net.close(socket)