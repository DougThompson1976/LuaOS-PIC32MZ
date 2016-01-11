-- WHITECAT sample code
--
-- Sample: tcp-echo-server.lua
--
-- Description:
--   This sample creates a TCP echo server on port 80

socket = net.socket(net.SOCK_STREAM)                              

client, ip, err = net.accept(socket, 80, 10)
if err == net.ERR_OK then
    print("New conection at "..net.unpackip( ip, '*s' ))

	while true do
		if err == net.ERR_OK then
			recv, err = net.recv(client, "*l")  	
			if err == net.ERR_OK then
				net.send(client, recv)
			end
		end
	end
end

net.close(client) 
net.close(socket)


socket = net.socket(net.SOCK_STREAM)     
ip = net.packip("37.59.156.38")
net.connect(socket,ip,1883)