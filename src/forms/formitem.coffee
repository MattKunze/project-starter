{ FormItemShape } = require './proptypes'

TextInput = React.createFactory require './textinput'
NumericInput = React.createFactory require './numericinput'
ListInput = React.createFactory require './listinput'

{ div, span, label, button, a } = React.DOM
cx = require 'classnames'

FormItem = React.createClass
  displayName: 'FormItem'

  propTypes: Object.assign
    labelColumns: React.PropTypes.number.isRequired
  , FormItemShape

  getDefaultProps: ->
    labelColumns: 2

  getInitialState: ->
    displayError: true

  render: ->
    controlColumns = if @props.label
      12 - @props.labelColumns
    else
      12

    sharedProps = Object.assign
      dirty: @props.value.isDirty()
      validating: @props.value.isValidating()
      onChange: @_changeValue
      onAccept: @_acceptChange
      onCancel: @_cancelChange
    , @props

    error = @props.value.getValidationError()

    div
      className: cx 'form-group',
        'has-success': sharedProps.dirty and not error?
        'has-error': error?
        'has-feedback': sharedProps.validating
    ,
      if @props.label
        label className: "control-label col-sm-#{@props.labelColumns}",
          if @props.showDetails
            a
              className: 'pull-left glyphicon glyphicon-menu-hamburger'
              onClick: @props.showDetails
          @props.label
      div className: "col-sm-#{controlColumns}",
        switch @props.type
          when 'text'
            TextInput sharedProps
          when 'number'
            NumericInput sharedProps
          when 'list'
            ListInput sharedProps

        if error and @state.displayError
          div className: 'alert alert-danger',
            button type: 'button', className: 'close', onClick: @_toggleError,
              String.fromCharCode 215 # &times;
            error

  _changeValue: (value) ->
    @props.value.change value
    @forceUpdate()

  _acceptChange: ->
    @setState displayError: true
    done = =>
      @forceUpdate() if @isMounted()
    @props.value.accept().then done, done

  _cancelChange: ->
    @props.value.cancel()
    @forceUpdate()

  _toggleError: ->
    @setState displayError: not @state.displayError

module.exports = FormItem
