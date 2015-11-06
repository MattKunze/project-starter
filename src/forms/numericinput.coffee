{ div, span, input } = React.DOM

NumericInput = React.createClass
  displayName: 'NumericInput'

  propTypes:
    placeholder: React.PropTypes.string

  render: ->
    div null,
      input
        type: 'number'
        className: 'form-control'
        placeholder: @props.placeholder
      span className: 'glyphicon glyphicon-asterisk form-control-feedback'

module.exports = NumericInput
