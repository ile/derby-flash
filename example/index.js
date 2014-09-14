var app = module.exports = require('derby').createApp('hello', __filename);
app.serverUse(module, 'derby-stylus');
app.loadViews(__dirname);
app.loadStyles(__dirname);
app.component(require('derby-flash')(app));

app.get('/', function(page, model) {
	model.flash('success', 'Congrats, derby-flash is on!');
	model.flash('warning', 'Warning .. be careful.');
	model.flash('info', 'Ok, nothing new here.');
	model.flash('error', 'An error happened! (Not really)');
	page.render();
});
