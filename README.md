#Derby-flash

This is similar to [connect-flash](https://github.com/jaredhanson/connect-flash) but for [Derby](http://derby.js). 

##Usage

```coffeescript
flash = require 'derby-flash'

app = (flash.init(derby.createApp(module)

app.flash 'error', 'An error happened!'
```

In templates:

```html

...

```