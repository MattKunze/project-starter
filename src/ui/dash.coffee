React = require 'react'
Connector = React.createFactory (require 'react-redux').Connector
Link = React.createFactory (require 'react-router').Link

{ div, h2, ul, li, a } = React.DOM

Dash = React.createClass
  displayName: 'Dash'

  render: ->
    Connector select: (state) ->
      state.user
    , DashContent

DashContent = React.createFactory React.createClass
  displayName: 'DashContent'

  render: ->
    clientId = '383eb1a3763e1abc40d0'

    div className: 'dash',
      h2 null, "Dash #{@props.authToken}"

      ul null,
        li null, Link to: 'org', 'Organization'
        li null, Link to: 'user', 'User'

      a
        href: "https://github.com/login/oauth/authorize?client_id=#{clientId}&scope=user,gist"
      , 'Authorize'

module.exports = Dash
