require 'normalize.css'
require 'bootstrap/less/bootstrap.less'
require 'bootstrap/less/theme.less'

{ div, h1, h3, button, pre } = React.DOM
cx = require 'classnames'

DynamicForm = React.createFactory require './forms/dynamicform'
EditItemPrompt = React.createFactory require './edititemprompt'
createValueBinding = require './forms/createvaluebinding'

UI = React.createClass
  displayName: 'UI'

  getInitialState: ->
    items: []
    values: {}
    validation: null # Validating, Success, Error
    editItem: null
    editItemPos: null

  componentWillMount: ->
    @setState items: [
      key: 'text'
      type: 'text'
      label: 'Text?'
      placeholder: 'Something'
      value: @_valueBinding 'text'
    ,
      key: 'int'
      type: 'number'
      label: 'Integer'
      placeholder: '42'
      value: @_valueBinding 'int', 123
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

      DynamicForm items: @state.items.map (item, index) =>
        Object.assign
          showDetails: @_editItem.bind @, index
        , item

      button className: 'btn btn-default', onClick: @_addItem, 'New'

      h3 null, 'Current State'

      pre null, JSON.stringify @state.values, null, '  '

      if @state.editItem?
        EditItemPrompt
          item: @state.editItem
          updateItem: @_updateItem.bind @, @state.editItemPos
          onCancel: @_cancelEdit

  _valueBinding: (key, initialValue = null) ->
    @setState values: Object.assign {}, @state.values, "#{key}": initialValue

    createValueBinding
      get: => @state.values[key]
      set: (value) =>
        new Promise (resolve, reject) =>
          setTimeout =>
            if /goats/i.test value
              reject 'no goats'
            else
              @setState values: Object.assign {}, @state.values, "#{key}": value
              resolve()
          , 1000

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

  _addItem: ->
    @setState
      editItem: type: 'text'
      editItemPos: -1

  _editItem: (pos) ->
    @setState
      editItem: @state.items[pos]
      editItemPos: pos

  _updateItem: (pos, item) ->
    item = Object.assign {}, item,
      value: @_valueBinding item.key

    if pos >= 0
      @state.items[pos] = item
    else
      @state.items.push item

    @setState editItem: null, editItemPos: null

  _cancelEdit: ->
    @setState editItem: null, editItemPos: null

module.exports = UI
