React = require 'react'
Radium = require 'radium'
{ div, form, input, i } = React.DOM

StoreWatchMixin = require '../storewatchmixin'
searchIntents = require '../search/searchintents'
searchStore = require '../search/searchstore'

Header = React.createClass Radium.wrap
  displayName: 'Header'

  mixins: [ StoreWatchMixin searchStore ]

  getStateFromStores: ->
    searchStore.getState()

  render: ->
    div className: 'navbar navbar-default',
      div className: 'container-fluid',
        div className: 'navbar-brand',
          i null, '#'
        form className: 'navbar-form', style: styles.form,
          input
            type: 'text'
            className: 'form-control'
            style: [ styles.input ]
            placeholder: 'Search'
            autoFocus: true
            value: @state.searchFilter
            onChange: @_updateSearch

  _updateSearch: (ev) ->
    searchIntents.updateSearch ev.target.value

styles =
  form:
    position: 'absolute'
    left: '20px'
    right: 0

  input:
    width: '100%'
    backgroundColor: 'transparent'
    border: 'none'
    borderRadius: 0
    boxShadow: 'none'
    outline: 'none'

    ':focus':
      borderBottom: '2px solid #eee'

module.exports = Header
