lora.setup()
lora.setAppEui("70B3D57ED0000412")
lora.setAppKey("AE07BD4621B7AAD81D5CAB3C5886BEEF")
lora.setAdr(true)

try(
    function()
        lora.join(true)
        lora.tx(false,1,"AE07BD4621B7AAD81D5CAB3C5886BEEF")
    end,
    function(error)
        print(error)
    end
)

try(
    function()
        print("test")
        a=a*2
    end,
    function(a)
        print("catch: "..a)
    end,
    function(a)
        print("finally")
    end
)