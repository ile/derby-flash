#Derby-flash

This is similar to [connect-flash](https://github.com/jaredhanson/connect-flash) but for [Derby](http://derby.js). 

##Installation

`npm install derby-flash`

Or from the sources:

```
git clone git://github.com/ile/derby-flash.git
cd derby-flash
npm install
make
```

##Usage

###Initialization

In app.js:

```coffeescript
derby = require 'derby'
flash = require 'derby-flash'

app = flash.init(derby.createApp(module))

```

###In code

```coffeescript
app.flash 'error', 'An error happened!'
```

###In templates

Defining the template component:

```html

<flash:>
    {#if _flash}
        {#each _flash.info as :msg}
            <div class="alert static alert-info">{:msg}</div>
        {/}
        {#each _flash.error as :msg}
            <div class="alert static alert-error">{:msg}</div>
        {/}
        {#each _flash.success as :msg}
            <div class="alert static alert-success">{:msg}</div>
        {/}
        {#each _flash.warning as :msg}
            <div class="alert static alert-warning">{:msg}</div>
        {/}
    {/}

```

Using it:

```html
<app:flash>

```
