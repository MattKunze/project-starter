React = require 'react'
require 'normalize.css'
require 'bootstrap/dist/css/bootstrap.css'
require 'bootstrap/dist/css/bootstrap-theme.css'

Header = React.createFactory require './header'

{ div, h1, p } = React.DOM

UI = React.createClass
  displayName: 'UI'

  render: ->
    div null,
      Header null

module.exports = UI
