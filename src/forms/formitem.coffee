{ FormItemShape } = require './proptypes'

TextInput = React.createFactory require './textinput'
NumericInput = React.createFactory require './numericinput'

{ div, span, label, button } = React.DOM
cx = require 'classnames'

FormItem = React.createClass
  displayName: 'FormItem'

  propTypes: Object.assign
    labelColumns: React.PropTypes.number.isRequired
  , FormItemShape

  getDefaultProps: ->
    labelColumns: 2

  getInitialState: ->
    isValidating: false
    error: null

  render: ->
    controlColumns = if @props.label
      12 - @props.labelColumns
    else
      12

    sharedProps = Object.assign
      isValidating: @state.isValidating
      onChange: @_changeValue
      onAccept: @_acceptChange
      onCancel: @_cancelChange
    , @props

    div
      className: cx 'form-group',
        'has-success': @props.value.dirty and not @state.error?
        'has-error': @state.error?
        'has-feedback': @state.isValidating
    ,
      if @props.label
        label className: "control-label col-sm-#{@props.labelColumns}",
          @props.label
      div className: "col-sm-#{controlColumns}",
        switch @props.type
          when 'text'
            TextInput sharedProps
          when 'number'
            NumericInput sharedProps

        if @state.error
          div className: 'alert alert-danger',
            button type: 'button', className: 'close', onClick: @_dismissError,
              String.fromCharCode 215 # &times;
            @state.error

  _changeValue: (value) ->
    @props.value.change value
    @forceUpdate()

  _acceptChange: ->
    return if @state.isValidating

    @setState isValidating: true
    done = (error) =>
      if @isMounted()
        @setState { isValidating: false, error }
    @props.value.accept().then done, done

  _cancelChange: ->
    return if @state.isValidating
    @props.value.cancel()
    @forceUpdate()

  _dismissError: ->
    @setState error: null

module.exports = FormItem
