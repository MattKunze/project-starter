React = require 'react'
UI = React.createFactory require './ui/ui'

router = require './router'
router.start()

renderApp = ->
  React.render (UI null), document.body

window.addEventListener 'DOMContentLoaded', renderApp
