{ div, span, input } = React.DOM

NumericInput = React.createClass
  displayName: 'NumericInput'

  propTypes:
    placeholder: React.PropTypes.string
    onChange: React.PropTypes.func.isRequired
    onAccept: React.PropTypes.func.isRequired
    onCancel: React.PropTypes.func.isRequired

  render: ->
    div null,
      input
        type: 'number'
        className: 'form-control'
        placeholder: @props.placeholder
        value: @props.value.get() or ''
        onChange: @_onChange
        onBlur: @props.onAccept
        onKeyUp: @_onKeyUp

      if @props.isValidating
        span className: 'glyphicon glyphicon-asterisk form-control-feedback'

  _onChange: (ev) ->
    @props.onChange ev.target.value

  _onKeyUp: (ev) ->
    if ev.key is 'Escape'
      @props.onCancel()
    else if ev.key is 'Enter'
      @props.onAccept()

module.exports = NumericInput
