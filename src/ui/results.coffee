_ = require 'lodash'
React = require 'react'

StoreWatchMixin = require '../storewatchmixin'
searchStore = require '../search/searchstore'

{ div, span, a } = React.DOM
cx = require 'classnames'

Results = React.createClass
  displayName: 'Results'

  mixins: [ StoreWatchMixin searchStore ]

  getStateFromStores: ->
    searchStore.getState()

  render: ->
    div className: 'results', style: styles.container,
      for item, index in @state.results
        Card _.assign
          key: item.full_name
          selected: index is @state.selected
          onClick: _.bind @_select, @, index
        , item

  _select: (key) ->
    console.warn "select #{key}"
    @setState selected: key

Card = React.createFactory React.createClass
  displayName: 'Card'

  render: ->
    div
      className: cx 'panel',
        'panel-info': @props.selected
        'panel-default': not @props.selected
      onClick: @props.onClick
     ,
      div className: 'panel-heading',
        span className: 'badge pull-right', @props.stargazers_count
        if @props.homepage
          a href: @props.homepage, target: '_blank', @props.full_name
        else
          @props.full_name
      div className: 'panel-body',
        @props.description

styles =
  container:
    margin: '0 1em'

module.exports = Results
