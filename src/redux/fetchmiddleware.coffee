doFetch = require '../utils/dofetch'

module.exports = ({ dispatch, getState }) ->
  (next) -> (action) ->
    if action.fetch
      { accessToken } = getState().user
      dispatch
        type: action.type
        promise: doFetch accessToken, action.fetch.url, action.fetch.transform
    else
      next action
