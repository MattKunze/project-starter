{ EventEmitter } = require 'events'
dispatcher = require './dispatcher'

class Store extends EventEmitter

  constructor: ->
    @dispatchToken = dispatcher.register @handleAction.bind @
    @state = @getInitialState?() or {}

    @_bindings = {}

    @initialize?()

  getState: -> @state

  setState: (newState) ->
    _.assign @state, newState
    @emitChange()

  addChangeListener: (cb) ->
    @on 'change', cb

  removeChangeListener: (cb) ->
    @on 'change', cb

  emitChange: ->
    @emit 'change', @state

  bindActions: (bindings) ->
    for type, handler of bindings
      @_bindings[type] or= []
      @_bindings[type].push _.bind handler, @

  handleAction: (action) ->
    handlers = @_bindings[action.type]
    if handlers
      handler action for handler in handlers

module.exports = Store
