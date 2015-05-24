dispatcher = require '../dispatcher'
{ Actions } = require '../constants'

module.exports =
  updateSearch: (filter) ->
    dispatcher.dispatch { type: Actions.SEARCH_CHANGED, filter }
