mac set appeui 70B3D57ED0000412
mac set appkey AE07BD4621B7AAD81D5CAB3C5886BEEF
mac set adr on
mac set ar on
mac set linkchk 1


lora.setup(lora.BAND868)
lora.setAppEui("70B3D57ED0000412")
lora.setAppKey("AE07BD4621B7AAD81D5CAB3C5886BEEF")
lora.setAdr(true)
lora.setAr(true)
lora.join(true)

thread.start(function()
try(
    function()
        a=a*2
    end,
    function(where, line, error)
        print(where)
        print(line)
        print(error)
    end
)
end)

lora.setup(lora.BAND868, false)
lora.setAppEui("70B3D57ED0000740")
lora.setAppKey("FB5E2EB1FDE0DCCB7B905685FD6B60A5")
lora.setAdr(false)
lora.setAr(true)
lora.setDr(0)
lora.join(lora.OTAA)
lora.tx(false,1,pack.pack(25.3))

lora.whenReceived(
    function(port, payload) print("received on port "..port..": "..payload) end
)
lora.tx(false,1,pack.pack(25.3))


lora.setup(lora.BAND868)
lora.setAppEui("70B3D57ED0000740")
lora.setAppKey("AE07BD4621B7AAD81D5CAB3C5886BEEF")
lora.setAdr(true)
lora.setAr(true)
lora.join(true)


mosquitto_sub -h staging.thethingsnetwork.org -u 70B3D57ED0000740 -P 9K+rP/5NY8cynVm2qdttGvjP+1M90wvIE4Vk+H31q0c= -t 70B3D57ED0000740/devices/*/up


mosquitto_pub -h staging.thethingsnetwork.org -t '70B3D57ED0000412/devices/0004A30B001AB6CD/down' -u 70B3D57ED0000412 -P 'Dkh24xMCH+hTbv08ynXVGjv07B1LX98H68w/fTxh+Xw=' -m '{ "payload":"SGVsbG8gd29ybGQK","port":1,"ttl":"1h"}'


os.logcons(true)
lora.setup(lora.BAND868, false)

uart.setup(2, 57600, 8, uart.PARNONE, uart.STOP1)
uart.read(4,"*l",true,1000*10)