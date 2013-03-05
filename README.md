#Derby-flash

This is similar to [connect-flash](https://github.com/jaredhanson/connect-flash) but for [Derby](http://derbyjs.com/). 

Derby-flash should work along connect-flash; the messages from connect-flash will be accessible from this module.

##Installation

Using [npm](https://npmjs.org/)

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

```javascript

var derby = require('derby')
    , flash = require('derby-flash')
    , app = flash.init(derby.createApp(module));


```

###In code

```javascript
model.flash('error', 'An error happened!');

```

... where `model` if your model object, wherever it is available.

###In templates

Defining the template component:

```html
<flash:>
    {#if _flash}
        {#each _flash.success as :msg}<div class="alert static alert-success">{:msg}</div>{/}
        {#each _flash.info as :msg}<div class="alert static alert-info">{:msg}</div>{/}
        {#each _flash.warning as :msg}<div class="alert static alert-warning">{:msg}</div>{/}
        {#each _flash.error as :msg}<div class="alert static alert-error">{:msg}</div>{/}
    {/}
```

Using it:

```html
<app:flash>

```

##FAQ

OK, I made this one up myself. But questions that may come up:

Q: What if I want to make a dismissible notification?  
A: You can use `model.del(node)` to delete a notification.

##Issues

Still new. Be cautious. There are some known problems with server side requests.
