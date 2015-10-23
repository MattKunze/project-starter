React = require 'react'
ReactDOM = require 'react-dom'
UI = React.createFactory require './ui'

renderApp = ->
  ReactDOM.render (UI null), document.querySelector '#app'

window.addEventListener 'DOMContentLoaded', renderApp
