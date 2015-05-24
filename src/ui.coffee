React = require 'react'

require 'normalize.css'
require './reset.css'

{ div, p, span, input } = React.DOM

UI = React.createClass
  displayName: 'UI'

  propTypes:
    message: React.PropTypes.string.isRequired

  render: ->
    div
      style:
        marginTop: '60px'
        marginLeft: '1em'
    ,
      Header null
      Footer null

      p null, @props.message

      input type: 'text', placeholder: 'Stuff here'

Header = React.createFactory React.createClass
  displayName: 'Header'

  render: ->
    div
      style:
        position: 'fixed'
        top: 0
        right: 0
        left: 0
        height: '50px'
        backgroundColor: '#c0392b'
        color: '#ecf0f1'
        fontSize: '150%'
        paddingTop: '.5em'
        paddingLeft: '.5em'
    ,
      span null, 'Fixed Header'

Footer = React.createFactory React.createClass
  displayName: 'Footer'

  render: ->
    div
      style:
        position: 'fixed'
        bottom: 0
        right: 0
        left: 0
        height: '40px'
        backgroundColor: '#f1c40f'
        fontSize: '125%'
        paddingTop: '.5em'
        paddingLeft: '.5em'
    ,
      span null, 'Fixed Footer'

module.exports = UI
