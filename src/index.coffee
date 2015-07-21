React = require 'react'
HashHistory = require 'react-router/lib/HashHistory'

Root = React.createFactory require './ui/root'
store = require './redux'

require 'whatwg-fetch'

renderApp = ->
  React.render (Root { store, history: HashHistory.history }), document.body

window.addEventListener 'DOMContentLoaded', renderApp
