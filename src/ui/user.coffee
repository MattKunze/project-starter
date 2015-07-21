_ = require 'lodash'
React = require 'react'
Link = React.createFactory (require 'react-router').Link
Connector = React.createFactory (require 'react-redux').Connector
{ bindActionCreators } = require 'redux'

userActions = require '../redux/useractions'

{ div, h2, ul, li, a } = React.DOM

Users = React.createClass
  displayName: 'Users'

  render: ->
    Connector select: (state) ->
      state.user
    , (props) =>
      actions = bindActionCreators userActions, props.dispatch
      UserContent _.assign params: @props.params, actions, props

UserContent = React.createFactory React.createClass
  displayName: 'UserContent'

  propTypes:
    status: React.PropTypes.string.isRequired
    gists: React.PropTypes.array
    loadUser: React.PropTypes.func.isRequired

  componentWillMount: ->
    if @props.params?.name
      @props.loadUser @props.params.name

  componentWillReceiveProps: (nextProps) ->
    nextName = nextProps.params?.name
    if nextName and nextName isnt @props.params?.name
      @props.loadUser nextName

  render: ->
    div className: 'user',
      h2 null, "#{@props.status}: User: #{@props.params.name}"

      GistList gists: @props.gists unless _.isEmpty @props.gists

GistList = React.createFactory React.createClass
  displayName: 'GistList'

  propTypes:
    gists: React.PropTypes.array.isRequired

  render: ->
    ul className: 'gists',
      for gist in @props.gists
        li key: gist.id,
          a href: gist.url, target: '_blank', gist.description

module.exports = Users
