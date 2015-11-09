{ div, span, input } = React.DOM

TextInput = React.createClass
  displayName: 'TextInput'

  propTypes:
    placeholder: React.PropTypes.string
    isValidating: React.PropTypes.bool
    onChange: React.PropTypes.func.isRequired
    onAccept: React.PropTypes.func.isRequired
    onCancel: React.PropTypes.func.isRequired

  render: ->
    div null,
      input
        type: 'text'
        className: 'form-control'
        placeholder: @props.placeholder
        value: @props.value.get() or ''
        onChange: @_onChange
        onBlur: @props.onAccept
        onKeyUp: @_onKeyUp

      if @props.isValidating
        span className: 'glyphicon glyphicon-grain form-control-feedback'

  _onChange: (ev) ->
    @props.onChange ev.target.value

  _onKeyUp: (ev) ->
    if ev.key is 'Escape'
      @props.onCancel()
    else if ev.key is 'Enter'
      @props.onAccept()

module.exports = TextInput
