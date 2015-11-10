{ div, span, input, button, ul, li, a } = React.DOM
cx = require 'classnames'

ResponsiveDropContent = React.createFactory require '../widgets/responsivedropcontent'

ListInput = React.createClass
  displayName: 'ListInput'

  propTypes:
    placeholder: React.PropTypes.string
    validating: React.PropTypes.bool
    onChange: React.PropTypes.func.isRequired
    onAccept: React.PropTypes.func.isRequired
    onCancel: React.PropTypes.func.isRequired

  getInitialState: ->
    open: false

  render: ->
    div null,
      div className: 'input-group',
        input
          type: 'text'
          className: 'form-control'
          placeholder: @props.placeholder
          value: @props.value.get() or ''
          onChange: @_onChange
          onBlur: @props.onAccept
          onKeyUp: @_onKeyUp

        span className: 'input-group-btn',
          button className: 'btn btn-default', onClick: @_toggle,
            span className: cx 'glyphicon',
              'glyphicon-chevron-down': not @state.open
              'glyphicon-chevron-up': @state.open

      ResponsiveDropContent null,
        ul className: 'dropdown-menu',
          li null, a null, 'First'
          li null, a null, 'Second'

  _onChange: (ev) ->
    @props.onChange ev.target.value

  _toggle: ->
    @setState open: not @state.open

  _onKeyUp: (ev) ->
    if ev.key is 'Escape'
      @props.onCancel()
    else if ev.key is 'Enter'
      @props.onAccept()

module.exports = ListInput
