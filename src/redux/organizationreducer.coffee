_ = require 'lodash'
{ Actions } = require '../constants'

initialState =
  status: 'unknown'
  details: {}
  members: []

handlers =
  "#{Actions.LOAD_ORGANIZATION}": (state, action) ->
    if action.error
      status: 'error'
      details:
        error: action.payload.message
      members: []
    else if action.payload
      status: 'loaded'
      details: action.payload
    else
      status: 'loading'
      details: {}
      members: []
  "#{Actions.LOAD_MEMBERS}": (state, action) ->
    if action.payload
      members: action.payload
    else
      members: []

module.exports = (state = initialState, action) ->
  if handlers[action.type]?
    _.assign {}, state, handlers[action.type] state, action
  else
    state
