-- WHITECAT sample code
--
-- Sample: mqtt.lua
--
-- Description:

led_lavabo = pio.PB_5
led_cocina = pio.PB_4

pio.pin.setdir(pio.OUTPUT, led_lavabo)
pio.pin.setdir(pio.OUTPUT, led_cocina)

broker = "cssiberica.com"
topic = "/VOICE/OUTPUT352991065590600"

received = function(len, payload) 
    action_on = false
    action_off = false
    action_where = 0

    for token in string.gmatch(payload, "[^%s]+") do
        action_on = action_on or (token == "encender")
        action_off = action_off or (token == "apagar")

        if (token == "cocina") then
            action_where = led_cocina
        end

        if (token == "lavabo") then
            action_where = led_lavabo
        end
    end

    if (action_on) then
        pio.pin.sethigh(action_where)
    end

    if (action_off) then
        pio.pin.setlow(action_where)
    end
end

client = mqtt.client("100", broker, 1883, false)
client:connect("","")
client:subscribe(topic, mqtt.QOS0, received)

