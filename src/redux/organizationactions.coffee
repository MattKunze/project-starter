_ = require 'lodash'
{ Actions } = require '../constants'

OrganizationActions =

  loadOrganization: (name) ->
    (dispatch, getState) ->
      dispatch OrganizationActions.loadOrganizationDetails name
        .then ->
          # also load members on success
          dispatch OrganizationActions.loadOrganizationMembers name

  loadOrganizationDetails: (name) ->
    type: Actions.LOAD_ORGANIZATION
    fetch:
      url: "https://api.github.com/orgs/#{name}",
      transform: (json) ->
        _.pick json, 'name', 'location', 'blog'

  loadOrganizationMembers: (name) ->
    type: Actions.LOAD_MEMBERS
    fetch:
      url: "https://api.github.com/orgs/#{name}/members",
      transform: (json) ->
        _.pluck json, 'login'

module.exports = OrganizationActions
