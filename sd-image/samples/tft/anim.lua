-- WHITECAT sample code
--
-- Show a 28 frame animation on the lcd

screen.init("st7735", screen.OrientationH0)
screen.clear(screen.rgb(0,0,0))

while true do
    screen.loadimage(0, 0, "/sd/samples/tft/f1.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f2.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f3.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f4.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f5.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f6.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f7.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f8.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f9.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f10.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f11.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f12.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f13.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f14.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f15.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f16.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f17.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f18.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f19.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f20.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f21.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f22.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f23.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f24.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f25.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f26.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f27.bmp")
    screen.loadimage(0, 0, "/sd/samples/tft/f28.bmp")
end