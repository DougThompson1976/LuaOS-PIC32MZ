i2c.setup(i2c.I2C1, 1000)
while true do
    i2c.start(i2c.I2C1)
    i2c.address(i2c.I2C1, 0x45, i2c.WRITE)
    i2c.write(i2c.I2C1, 0x24)
    i2c.write(i2c.I2C1, 0x0b)
    i2c.stop(i2c.I2C1)

    i2c.start(i2c.I2C1)
    if i2c.address(i2c.I2C1, 0x45, i2c.READ) then
        msbt = i2c.read(i2c.I2C1)
        lsbt = i2c.read(i2c.I2C1)
        crct = i2c.read(i2c.I2C1)

        msbh = i2c.read(i2c.I2C1)
        lsbh = i2c.read(i2c.I2C1)
        crch = i2c.read(i2c.I2C1)

        i2c.stop(i2c.I2C1)

        temp = -45 + 175 * (((msbt << 8) | lsbt) / 65535)
        hum  = 100 * (((msbh << 8) | lsbh) / 65535)
        print("temp: "..temp..", hum: "..hum)
    else
        print("no data")
    end

    tmr.delay(2)
end


    -- Write byte
    i2c.setup(i2c.I2CBB1, 1000, pio.PE_0, pio.PD_10)
    i2c.start(i2c.I2CBB1)
    i2c.address(i2c.I2CBB1, 0x51, i2c.WRITE)
    i2c.write(i2c.I2CBB1,0x00)
    i2c.write(i2c.I2CBB1,0x40)
    i2c.write(i2c.I2CBB1,65)
    i2c.stop(i2c.I2CBB1)

    -- Immediate Address Read
    i2c.setup(i2c.I2CBB1, 1000, pio.PE_0, pio.PD_10)
    i2c.start(i2c.I2CBB1)
    i2c.address(i2c.I2CBB1, 0x51, i2c.READ)
    i2c.read(i2c.I2CBB1)
    i2c.stop(i2c.I2CBB1)

    -- Selective Read
    i2c.setup(i2c.I2CBB1, 1000, pio.PE_0, pio.PD_10)
    i2c.start(i2c.I2CBB1)
    i2c.address(i2c.I2CBB1, 0x51, i2c.WRITE)
    i2c.write(i2c.I2CBB1,0x00)
    i2c.write(i2c.I2CBB1,0x40)
    i2c.start(i2c.I2CBB1)
    i2c.address(i2c.I2CBB1, 0x51, i2c.READ)
    print(i2c.read(i2c.I2CBB1))
    i2c.stop(i2c.I2CBB1)

