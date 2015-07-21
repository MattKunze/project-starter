_ = require 'lodash'
React = require 'react/addons'
Connector = React.createFactory (require 'react-redux').Connector
{ bindActionCreators } = require 'redux'
{ Navigation } = require 'react-router'
Link = React.createFactory (require 'react-router').Link

organizationActions = require '../redux/organizationactions'

{ div, h2, input, button, pre, ul, li } = React.DOM

Organization = React.createClass
  displayName: 'Organization'

  render: ->
    Connector select: (state) ->
      state.organization
    , (props) =>
      actions = bindActionCreators organizationActions, props.dispatch
      OrganizationContent _.assign params: @props.params, actions, props

OrganizationContent = React.createFactory React.createClass
  displayName: 'OrganizationContent'

  getInitialState: ->
    searchOrg: ''

  mixins: [ React.addons.LinkedStateMixin, Navigation ]

  propTypes:
    status: React.PropTypes.string.isRequired
    details: React.PropTypes.object
    dispatch: React.PropTypes.func
    loadOrganization: React.PropTypes.func.isRequired

  componentWillMount: ->
    if @props.params?.name
      @props.loadOrganization @props.params.name

  componentWillReceiveProps: (nextProps) ->
    nextName = nextProps.params?.name
    if nextName and nextName isnt @props.params?.name
      @props.loadOrganization nextName

  render: ->
    div className: 'organization',
      input
        type: 'text'
        placeholder: 'Organization'
        valueLink: @linkState 'searchOrg'

      button onClick: @_search, 'Search'

      if @props.params?.name
        OrganizationDetails
          name: @props.params.name
          status: @props.status
          details: @props.details
          members: @props.members

  _search: ->
    @transitionTo "org/#{@state.searchOrg}" if @state.searchOrg

OrganizationDetails = React.createFactory React.createClass
  displayName: 'OrganizationDetails'

  propTypes:
    status: React.PropTypes.string.isRequired
    name: React.PropTypes.string.isRequired
    details: React.PropTypes.object

  render: ->
    div className: 'details',
      h2 null, "#{@props.status}: Organization: #{@props.name}"

      pre null, JSON.stringify @props.details, null, '  '

      ul className: 'members',
        for login in @props.members
          li key: login,
            Link to: "user/#{login}", login

module.exports = Organization
