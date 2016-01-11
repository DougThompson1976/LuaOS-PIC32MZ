-- WHITECAT sample code
--
-- Sample: mqtt.lua
--
-- Description:

client = mqtt.client("100", "cssiberica.com", 1883, false)
client:connect("","")

received1 = function(len, payload) 
    print("c1 len: "..len.." payload: "..payload)
end

received2 = function(len, payload) 
    print("c2 len: "..len.." payload: "..payload)
end

client:publish("/100","hola",mqtt.QOS0) 