flash = module.exports

flash.init = (app) ->

	show = ->
		model = this.view.model
		flashq = model.get('_flashq') or {}
		flashq2 = model.get('_flashq2') or {}

		for type of flashq2
			flashq[type] ||= []
			for msg in flashq2[type]
				flashq[type].push msg

		model.set '_flash', flashq
		model.del '_flashq'
		model.del '_flashq2'

	app.on 'render', show

	app.flash = (type, msg) ->
		this.view.model.push "_flashq.#{type}", msg

	originalRouter = app.router

	middleware = (req, res, next) ->
		model = req.getModel()
		model.set '_flashq2', req.flash()
		(originalRouter())(req, res, next)

	app.router = ->
		middleware

	app
