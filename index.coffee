racer = require('racer')
Model = racer.Model

module.exports = (app, options = {}) ->

	class Flash
		view: __dirname

		app.on 'render', (app) ->
			model = app.model
			flashq = model.get('_flash.flashq') or {}

			if flashq
				for type of flashq
					for obj in flashq[type]
						if typeof obj.msg is 'string' and model.toast and (options.useToast or obj.toast)
							model.toast type, obj.msg
						else
							model.root.push "_page.flash.#{type}", obj.msg

			model.del '_flash.flashq'

		Model::flash = (type, msg, useToast) ->
			# set if msg present
			if type and msg
				if @req?.flash and not useToast
					@req.flash type, msg
				else
					@root.push "_flash.flashq.#{type}", { msg: msg, toast: useToast  }

		originalRouter = app.router

		middleware = (req, res, next) ->
			if req.flash
				model = req.getModel()
				msgs = req.flash()
				for type of msgs
					for msg in msgs[type]
						if typeof msg is 'string' # string is the "normal" case
							model.push "_flash.flashq.#{type}", { msg: msg }
						else # is object - for setting up more complex scenarios
							for obj of msg
								model.set "_flash.flashq.#{type}.#{obj}", msg[obj]

			(originalRouter())(req, res, next)

		app.router = ->	middleware
