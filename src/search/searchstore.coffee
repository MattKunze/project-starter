{ Actions } = require '../constants'
Store = require '../store'

class SearchStore extends Store

  initialize: ->
    @bindActions {
      "#{Actions.SEARCH_CHANGED}": @_searchChanged
    }

  getInitialState: ->
    searchFilter: ''

  _searchChanged: (action) ->
    @setState searchFilter: action.filter

module.exports = new SearchStore
