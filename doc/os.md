# os module

This module it's a standard Lua module that allows to access some operating
system facilities. The whitecat adds new facilities to this module.

Please, refer to (http://www.lua.org/manual/5.3/manual.html#6.9) to know more 
about the standard features of this module.


## os.ls([path])

List directory contents.

Arguments:

* path: directory path. This argument it's optional, and if is not provided is
listed the contents of the current directory. Path can be absolute or relative
to current working directory.

Returns: nothing

```lua
-- List the root directory contents

os.ls("/")
d              -        tmp
d              -        www
d              -        conf
d              -        log
d              -        lib
f             27        test1.lua
f            956        autorun.lua
f           1871        lcd.lua
```

Directory contents is listed on the screen in columns (separated by tab):

* first column: entry type (d = directory / f = file)
* second column: entry size in bytes
* third column: entry name


## os.cd(path)

Change the current working directory.

Arguments:

* path: directory path. Path can be absolute or relative to current working 
directory.

Returns: true if success


```lua
-- Change the current directory to /lib

os.cd("/lib")
true
```


## os.pwd()

Get the current working directory.

Arguments: nothing

Returns: the current directory


```lua
-- Get the current working directory

os.pwd()
/lib
```


## os.mkdir(path)

Make a directory.

Arguments:

* directory path. Path can be absolute or relative to current working 
directory.

Returns: true if success

```lua
-- Make a new directory named test into the current working directory

os.mkdir("test")
true
```


## os.edit(file)

Edits a file.

Arguments:

* file: file path. Can be absolute or relative to current working 
directory.

Returns: nothing

```lua
-- Edit utorun.lua

os.edit("autorun.lua")
true
```


## os.clear()

Clears the screen.

Arguments: nothing

Returns: nothing