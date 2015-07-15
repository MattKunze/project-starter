_ = require 'lodash'
kefir = require 'kefir'

{ Actions } = require '../constants'
Store = require '../store'

class SearchStore extends Store

  initialize: ->
    @bindActions {
      "#{Actions.SEARCH_CHANGED}": @_searchChanged
    }

    searchStream = (kefir.fromEvents @, 'search')
      .throttle 1000
      .flatMapLatest (query) =>
        if query
          kefir.fromPromise @_search query
        else
          kefir.constant []
      .map (results) =>
        @setState { results }

    searchStream.log()

  getInitialState: ->
    searchFilter: ''
    results: []

  _searchChanged: (action) ->
    @setState searchFilter: action.filter
    @emit 'search', action.filter

  _encode: (params) ->
    (for key, value of params
      "#{key}=#{encodeURIComponent value}"
    ).join '&'

  _search: (q) ->
    console.warn "search #{q}"
    params = { q , sort: 'stars', order: 'desc' }
    window.fetch "https://api.github.com/search/repositories?#{@_encode params}"
      .then (results) ->
        results.json()
      .then (json) ->
        _.map json.items, (item) ->
          _.pick item, 'full_name', 'description', 'homepage', 'stargazers_count'
      .catch (error) ->
        console.error error

module.exports = new SearchStore
