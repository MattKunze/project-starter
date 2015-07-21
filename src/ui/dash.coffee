React = require 'react'
Link = React.createFactory (require 'react-router').Link

{ div, h2, ul, li } = React.DOM

Dash = React.createClass
  displayName: 'Dash'

  render: ->
    div className: 'dash',
      h2 null, 'Dash'

      ul null,
        li null, Link to: 'org', 'Organization'
        li null, Link to: 'users', 'Users'

module.exports = Dash
