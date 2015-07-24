React = require 'react'

authActions = require '../redux/authactions'

{ div } = React.DOM

Auth = React.createClass
  displayName: 'Auth'

  contextTypes:
    store: React.PropTypes.object.isRequired

  componentDidMount: ->
    @context.store.dispatch authActions.saveToken @props.params.token
    
  render: ->
    div null, "auth: #{@props.params.token}"

module.exports = Auth
