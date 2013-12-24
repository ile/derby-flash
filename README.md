#Derby-flash

This is similar to [connect-flash](https://github.com/jaredhanson/connect-flash) but for [Derby](http://derbyjs.com/). 

Derby-flash should work along connect-flash; the messages from connect-flash will be accessible from this module.

##Requirements

- [Node.js](http://nodejs.org)
- [Derby](http://derbyjs.com/)


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
var app = require('derby').createApp(module)
	.use(require('derby-flash'));
```

Derby-flash also accepts an `options` object:

```javascript
var app = require('derby').createApp(module)
	.use(require('derby-flash'), { useToast: true });
```

Currently the supported options are:

- *useToast: boolean*  
	use [derby-ui-toast](https://github.com/ile/derby-ui-toast) to show the messages, if available.

###In templates

If you are not using derby-ui-toast along with derby-flash, you can use the built-in template:

```html
<derby-flash:flash>

```

###Adding messages

```javascript
model.flash('error', 'An error happened!');

```

... where `model` if your model object, wherever it is available.

##FAQ

OK, I made this one up myself. But questions that may come up:

Q: What if I want to make a dismissible notification?  
A: You can, for example, use `model.del(node)` to delete a notification. `node` is a DOM or jQuery node.

##Issues

Still new. Be cautious. There are some known problems with server side requests.

##Credits

- https://github.com/jamesknelson/derby-i18n for the module structure

##License

(The MIT License)

Copyright (c) 2013 Ilkka Huotari

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
