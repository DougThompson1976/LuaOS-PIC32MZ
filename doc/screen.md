# screen module

This module provides functions to manage external displays connected to the
whitecat.

Actually this module supports displays with one of the following chipsets:

* st7735


## screen.init(chipset, orientation)

Init the screen, and sets:

* cursor to (0,0) position
* foreground color to white
* background color to black
* stroke cole to white

Arguments:

* chipset: chipset name

* orientation:  can be either screen.OrientationV0, screen.OrientationV1,
screen.OrientationH0, screen.OrientationH1.

Returns: nothing.


```lua
-- Init the screen using a st7735 chipset, and orientation horizontal 1
screen.init("st7735", screen.OrientationH1)
```


## screen.width()

Get the screen width, in pixels.

Arguments: nothing.
Returns: screen width in pixels.


## screen.height()

Get the screen height, in pixels.

Arguments: nothing.
Returns: screen height in pixels.


## screen.rgb(red, green, blue)

Encodes a color expressed in rgb components into a 32 bit integer according to
the display's capabilities.

Arguments:

* red: red component, from 0 to 255.
* green: green component, from 0 to 255.
* blue: blue component, from 0 to 255.

Returns: the encoded color.


```lua
-- Red color
red = screen.rgb(255, 0, 0)

-- White color
white = screen.rgb(255, 255, 255)
```


## screen.clear(color)

Clear the screen, fill it with color, and puts the cursor position to
(x, y) = (0, 0)

Arguments:

* color: screen color, coded with the screen.rgb function.

Returns: nothing.


```lua
-- Clear the screen, and fill it with black color
screen.clear(screen.rgb(0,0,0))
```


## screen.pixel(x, y, color)

Draw a pixel at (x, y) position.

Arguments:

* x: pixel's screen x coordinate
* y: pixel's screen y coordinate
* color: pixel's color, coded with the screen.rgb function

Returns: nothing.


```lua
-- Draw a red pixel at the center of the screen
screen.pixel(screen.width()/2, screen.height() / 2, screen.rgb(255,0,0)) 
```


# screen.setxy(x, y)

Set the cursor at (x, y) position.

Arguments:

* x: cursor's screen x coordinate
* y: cursor's screen y coordinate


Returns: nothing.


```lua
-- Set the cursor at (0,0)
screen.setxy(0,0)
```

# screen.getxy()

Get the current (x,y) cursor position.

Arguments: nothing

Returns: current position


```lua
-- Get the cursor position
x, y = screen.getxy()
```


## screen.setfont(font name)

Sets the current font.

Arguments:

* font name: font name, stored in /sys/font

Returns: nothing.


```lua
-- Set the current font to gohu-11 (gohu, size 11 pixels)
screen.setfont("gohu-11")
```


## screen.setforeground(color)

Set the current foreground color used for drawing text.

Arguments:

* color: foreground color, coded with the screen.rgb function.

Returns: nothing.


```lua
-- Set foreground color to red
screen.setforeground(screen.rgb(255, 0, 0))
```


## screen.setbackground(color)

Set the current foreground color used for drawing text.

Arguments:

* color: foreground color, coded with the screen.rgb function.

Returns: nothing.


```lua
-- Set foreground color to black
screen.setbackground(screen.rgb(0, 0, 0))
```


## screen.text([x], [y], text)

Draw a text on the screet at (x,y) position, or current cursor position. Text is
drawn with the current foregroud and background colors set with the 
screen.setforeground and screen.setbackground functions.

If text contains the \n character cursor is updated the initial position of a 
new line.

Arguments:

* x: text's screen x coordinate. Optional, if not present draw text on current
cursor position.
* y: text's screen y coordinate. Optional, if not present draw text on current
cursor position.

Returns: nothing


```lua
-- Draw text at (0,0) position
screen.text(0,0, "whitecat")

-- Draw text at current cursor.position
screen.text(0,0, ".org")
```


## screen.loadimage(x, y, filename)

Load an image in bmp format.

Arguments:

* x: images's screen x coordinate
* y: images's screen y coordinate
* filename: image filename path

Returns: nothing.

```lua
-- Load the whitecat.bmp on the screen
screen.loadimage(0,0, "/sd/whitecat.bmp")
```

