require 'normalize.css'
require 'bootstrap/less/bootstrap.less'
require 'bootstrap/less/theme.less'

{ div, h1, h3, button, pre } = React.DOM
cx = require 'classnames'

DynamicForm = React.createFactory require './forms/dynamicform'

UI = React.createClass
  displayName: 'UI'

  getInitialState: ->
    items: []
    values: {}
    validation: null # Validating, Success, Error

  componentWillMount: ->
    valueBinding = (key, initialValue = null) =>
      @setState values: Object.assign {}, @state.values, "#{key}": initialValue

      pendingValue = undefined
      acceptPromise = null
      binding =
        get: =>
          if pendingValue is undefined
            @state.values[key]
          else
            pendingValue
        change: (value) ->
          binding.dirty = true
          pendingValue = value
        accept: =>
          return Promise.resolve() if pendingValue is undefined
          return acceptPromise if acceptPromise
          acceptPromise = new Promise (resolve, reject) =>
            setTimeout =>
              acceptPromise = null
              if /goats/i.test pendingValue
                reject 'no goats'
              else
                @setState values: Object.assign {}, @state.values, "#{key}": pendingValue
                binding.cancel()
                resolve()
            , 1000
        cancel: ->
          pendingValue = undefined
          binding.dirty = false

    @setState items: [
      type: 'text'
      label: 'Text?'
      placeholder: 'Something'
      value: valueBinding 'text'
    ,
      type: 'number'
      label: 'Integer'
      placeholder: '42'
      value: valueBinding 'int', 123
    ]

  render: ->
    div className: 'container',
      div className: 'btn-group pull-right',
        button
          type: 'button'
          style: { marginTop: '20px' }
          className: cx 'btn',
            'btn-default': not @state.validation
            'btn-info': @state.validation is 'Validating'
            'btn-success': @state.validation is 'Success'
            'btn-danger': @state.validation is 'Error'
          onClick: @_validate
        , @state.validation or 'Validate'

      h1 null, 'Dynamic Form Playground'

      DynamicForm items: @state.items

      h3 null, 'Current State'

      pre null, JSON.stringify @state.values, null, '  '

  _validate: ->
    @setState validation: 'Validating'
    Promise.all @state.items.map (item) -> item.value.accept()
      .then =>
        @setState validation: 'Success'
      .catch (error) =>
        console.error "validation fail: #{error}"
        @setState validation: 'Error'
      .then =>
        setTimeout =>
          @setState validation: null
        , 1500


module.exports = UI
