UI = React.createFactory require './ui'

renderApp = ->
  ReactDOM.render (UI null), document.body

window.addEventListener 'DOMContentLoaded', renderApp
