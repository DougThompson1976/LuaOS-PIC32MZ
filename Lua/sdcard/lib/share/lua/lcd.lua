local lcd = {}

-- PORTE: E7 E6 E5 E4  E3  E2  E1  E0
--        RS RW EN NC  DB7 DB5 DB6 DB4
local lcd_port = pio.PE

-- Control bits
local lcd_en	 = (1 << 5) 
local lcd_rw   = (1 << 6)
local lcd_rs   = (1 << 7)

local function lcd_send_cmd(data) 
	-- Send lower 4-bits
	pio.port.setval(((data & 0x0f)) | lcd_en, lcd_port)
	pio.port.setval(((data & 0x0f)), lcd_port)
	
	-- Send higher 4-bits
	pio.port.setval(((data & 0xf0) >> 4) | lcd_en, lcd_port)
	pio.port.setval(((data & 0xf0) >> 4), lcd_port)
end

local function lcd_send_ins(data) 
	-- Send higher 4-bits
	pio.port.setval(((data & 0xf0) >> 4) | lcd_en, lcd_port)
	pio.port.setval(((data & 0xf0) >> 4), lcd_port)

	-- Send lower 4-bits
	pio.port.setval(((data & 0x0f)) | lcd_en, lcd_port)
	pio.port.setval(((data & 0x0f)), lcd_port)
end

local function lcd_send_chr(data)
	-- Send higher 4-bits
	pio.port.setval(((data & 0xf0) >> 4) | lcd_en | lcd_rs, lcd_port)
	pio.port.setval(((data & 0xf0) >> 4) | lcd_rs, lcd_port)

	-- Send lower 4-bits
	pio.port.setval(((data & 0x0f)) | lcd_en | lcd_rs, lcd_port)
	pio.port.setval(((data & 0x0f)) | lcd_rs, lcd_port)
end

local function lcd_delay(msec) 
	tmr.delay(tmr.SYS_TIMER, tmr.MSEC * msec)
end

function lcd.clear()
	lcd_send_ins(0x01)
end

function lcd.write(str)
	for i = 1, string.len(str) do
		lcd_send_chr(string.byte(str, i))
	end
end

function lcd.init()
	pio.port.setdir(pio.OUTPUT, lcd_port)
	pio.port.setlow(lcd_port)
	
	-- Init sequence
	lcd_delay(20)

	lcd_send_cmd(0x30)
	lcd_delay(10)

	lcd_send_cmd(0x30)
	lcd_delay(1)

	lcd_send_cmd(0x30)
	lcd_delay(1)
	
	lcd_send_cmd(0x20) -- Function set (4 bit interface)
	lcd_delay(1)
	
	lcd_send_ins(0x28) -- 4-bit mode, 2 line display, 5x8 dots
	lcd_send_ins(0x0c) -- Display no cursor - no blink
	lcd_send_ins(0x06) -- Automatic Increment - No Display shift
	lcd_send_ins(0x01) -- Clear display
end

return lcd