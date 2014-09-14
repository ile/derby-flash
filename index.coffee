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
				if flashq
					for type of flashq
						for msg in flashq[type]
							if options.useToast and model.toast
								model.toast type, msg
			else
				model.root.set '_page.flash', flashq

			model.del '_flash.flashq'

		Model::flash = (type, msg, useToast) ->
			# set if msg present
			if type and msg
				if @req?.flash and not useToast
					@req.flash type, msg
				else
					@root.push "_flash.flashq.#{type}", msg
			# otherwise get
			# not really needed
			###
			else if type
				if @req?.flash
					@req.flash type
				else
					res = @root.get "_flash.flashq.#{type}"
					@root.del "_flash.flashq.#{type}"
					res
			else
				if @req?.flash
					@req.flash
				else
					all = @root.get "_flash.flashq"
					@root.del "_flash.flashq"
					all
			###

		originalRouter = app.router

		middleware = (req, res, next) ->
			if req.flash
				model = req.getModel()
				msgs = req.flash()
				for type of msgs
					for msg in msgs[type]
						if typeof msg is 'string'
							model.push "_flash.flashq.#{type}", msg
						else # is object
							for obj of msg
								model.set "_flash.flashq.#{type}.#{obj}", msg[obj]

			(originalRouter())(req, res, next)

		app.router = ->	middleware
