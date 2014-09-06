racer = require('racer')
Model = racer.Model

module.exports = (app, options) ->

	options ||= {}

	class Flash
		view: __dirname

		app.on 'render', (app) ->
			model = app.model
			flashq = model.get('_flash.flashq') or {}

			if options.useToast and model.toast
				for msg in flashq
					model.toast msg.type, msg.msg
			else
				model.set '_page.flash', flashq

			model.del '_flash.flashq'

		Model::flash = (type, msg) ->
			if @req?.flash
				@req.flash type, msg
			else
				@root.push "_flash.flashq", { type: type, msg: msg }

		originalRouter = app.router

		middleware = (req, res, next) ->
			if req.flash
				model = req.getModel()
				msgs = req.flash()
				for type of msgs
					for msg in type
						model.push "_flash.flashq", { type: type, msg: msg }

			(originalRouter())(req, res, next)

		app.router = ->	middleware
