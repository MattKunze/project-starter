_ = require 'lodash'

searchIntents = require './search/searchintents'
searchStore = require './search/searchstore'

router =
  parseLocation: (query = window.location.hash) ->
    query = query.substring 1 if query[0] is '#'

    route: query.split '/'

  start: ->
    window.addEventListener 'hashchange', _.bind @applyRoute, @
    searchStore.on 'change', ->
      route = searchStore.getState().searchFilter
      history.replaceState null, null, "##{route}"

    @applyRoute()

  applyRoute: ->
    parsed = @parseLocation()

    searchIntents.updateSearch parsed.route[0]

module.exports = router
