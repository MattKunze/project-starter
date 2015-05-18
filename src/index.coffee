React = require 'react'
UI = React.createFactory require './ui'

renderApp = ->
  React.render (UI null), document.body

window.addEventListener 'DOMContentLoaded', renderApp
