{ div, span, input } = React.DOM

TextInput = React.createClass
  displayName: 'TextInput'

  propTypes:
    placeholder: React.PropTypes.string

  render: ->
    div null,
      input
        type: 'text'
        className: 'form-control'
        placeholder: @props.placeholder
      span className: 'glyphicon glyphicon-warning-sign form-control-feedback'

module.exports = TextInput
