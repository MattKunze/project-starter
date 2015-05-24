React = require 'react'
AppLayout = React.createFactory require './applayout'
UI = React.createFactory require './ui'

uiProps =
  message: 'Nothing yet'

updateMessage = (message) ->
  uiProps.message = message
  renderApp()

renderApp = ->
  component = AppLayout { updateMessage },
    UI uiProps
  React.render component, document.body

window.addEventListener 'DOMContentLoaded', renderApp
