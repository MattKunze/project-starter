_ = require 'lodash'
{ Actions } = require '../constants'
doFetch = require '../utils/dofetch'

OrganizationActions =

  loadOrganization: (name) ->
    (dispatch) ->
      details = OrganizationActions.loadOrganizationDetails name
      dispatch details

      # also load members on success
      details.promise.then ->
        dispatch OrganizationActions.loadOrganizationMembers name

  loadOrganizationDetails: (name) ->
    type: Actions.LOAD_ORGANIZATION
    promise: doFetch "https://api.github.com/orgs/#{name}", (json) ->
      _.pluck json, 'name', 'location', 'blog'

  loadOrganizationMembers: (name) ->
    type: Actions.LOAD_MEMBERS
    promise: doFetch "https://api.github.com/orgs/#{name}/members", (json) ->
      _.pluck json, 'login'

module.exports = OrganizationActions
