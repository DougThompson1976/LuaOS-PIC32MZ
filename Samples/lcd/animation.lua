-- WHITECAT sample code
--
-- Show a 28 frame animation on the lcd

screen.init("st7735", screen.OrientationH0)
screen.clear(screen.rgb(0,0,0))

while true do
    screen.loadimage(0, 0, "/samples/lcd/f1.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f2.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f3.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f4.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f5.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f6.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f7.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f8.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f9.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f10.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f11.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f12.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f13.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f14.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f15.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f16.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f17.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f18.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f19.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f20.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f21.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f22.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f23.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f24.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f25.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f26.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f27.bmp")
    screen.loadimage(0, 0, "/samples/lcd/f28.bmp")
end