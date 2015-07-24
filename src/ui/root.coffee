React = require 'react'
Link = React.createFactory (require 'react-router').Link
Router = React.createFactory (require 'react-router').Router
Route = React.createFactory (require 'react-router').Route
Redirect = React.createFactory (require 'react-router').Redirect
Provider = React.createFactory (require 'react-redux').Provider

Auth = require './auth.coffee'
Organization = require './organization.coffee'
User = require './user.coffee'
Dash = require './dash.coffee'

authActions = require '../redux/authactions'

require 'normalize.css'

{ div, h1 } = React.DOM

Root = React.createClass
  displayName: 'Root'

  propTypes:
    history: React.PropTypes.object.isRequired
    store: React.PropTypes.object.isRequired

  componentDidMount: ->
    @props.store.dispatch authActions.checkAuthorization()

  render: ->
    Provider store: @props.store, =>
      Router history: @props.history,
        Route component: App,
          Route path: 'auth/:token', component: Auth
          Route path: 'org', component: Organization
          Route path: 'org/:name', component: Organization
          Route path: 'user/:name', component: User
          Route path: '/', component: Dash

App = React.createClass
  displayName: 'App'

  render: ->
    div className: 'app',
      h1 null, Link to: '/', 'Application'
      @props.children

module.exports = Root
