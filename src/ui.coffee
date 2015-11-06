require 'normalize.css'

{ div, h1, p } = React.DOM

UI = React.createClass
  displayName: 'UI'

  render: ->
    div null,
      h1 null, 'Project Starter Template'

      p null, 'The tooling is done, get to work :)'

module.exports = UI
