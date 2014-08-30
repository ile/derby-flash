racer = require('racer')
Model = racer.Model

module.exports = (app, options) ->

	options ||= {}

	class Flash
		view: __dirname

		create: ->
			model = this.model.root
			flashq = model.get('_flash.flashq') or {}
			flashq2 = model.get('_flash.flashq2') or {}

			for type of flashq2
				flashq[type] ||= []
				for msg in flashq2[type]
					flashq[type].push msg

			if options.useToast
				for type, msgs of flashq
					for msg in msgs
						model.toast type, msg
			else
				model.set '_page.flash', flashq

			model.del '_flash.flashq'
			model.del '_flash.flashq2'

		Model::flash = (type, msg) ->
			if @req?.flash
				@req.flash type, msg
			else
				@root.push "_flash.flashq.#{type}", msg

		originalRouter = app.router

		middleware = (req, res, next) ->
			if req.flash
				model = req.getModel()
				model.root.set '_flash.flashq2', req.flash()

			(originalRouter())(req, res, next)

		app.router = ->	middleware
