# mqtt module



## client = mqtt.client(clientid, host, port, secure)

Creates a new mqtt client instance.

Arguments:

* clientid: client identifier
* host: broker domain name or ip
* port: broker port (tipically 1883)
* secure: true for secure communicacition, false for non-secure comunication

Returns: a client instance. You must store this instance into a variable for
further operations with it.

```lua
client = mqtt.client("100", "mqtt.isatpoint.com", 1883, false)
```


## instance:connect(username,password)

Connects the client instance to the broker.

Arguments:

* username: user name
* password: password 

Returns: nothing

```lua
client:connect("","")
```

