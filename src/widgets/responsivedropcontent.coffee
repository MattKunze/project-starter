{ div } = React.DOM

ResponsiveDropContent = React.createClass
  displayName: 'ResponsiveDropContent'

  render: ->
    div
      className: 'dropdown-content open'
      style:
        position: 'absolute'
        left: '15px'
        right: '15px'
        border: '1px solid black'
    ,
      @props.children

module.exports = ResponsiveDropContent
