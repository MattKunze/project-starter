_ = require 'lodash'

StoreWatchMixin = (stores) ->
  unless _.isArray stores
    stores = [ stores ]

  getInitialState: ->
    @getStateFromStores()

  componentDidMount: ->
    store.addChangeListener @_onChange for store in stores

  componentWillUnmount: ->
    store.removeChangeListener @_onChange for store in stores

  _onChange: ->
    @setState @getStateFromStores()

module.exports = StoreWatchMixin
