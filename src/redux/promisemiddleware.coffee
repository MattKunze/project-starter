_ = require 'lodash'

module.exports = ({ dispatch }) ->
  (next) -> (action) ->
    if action.promise?
      { type } = action
      # dispatch an empty action to indicate the promise has started
      dispatch { type }
      # then hook up success/error handlers
      action.promise.then (payload) ->
        dispatch { type, payload }
      , (error) ->
        dispatch { type, payload: error, error: true }
    else
      next action
