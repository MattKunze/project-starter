{ Actions } = require '../constants'

initialState =
  status: 'unknown'
  gists: []

handlers =
  "#{Actions.LOAD_USER}": (state, action) ->
    if action.error
      status: 'error'
      gists: []
    else
      status: if action.payload? then 'loaded' else 'loading'
      gists: action.payload or []

module.exports = (state = initialState, action) ->
  if handlers[action.type]?
    _.assign {}, state, handlers[action.type] state, action
  else
    state
