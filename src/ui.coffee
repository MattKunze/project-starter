_ = require 'lodash'
React = require 'react'

require 'normalize.css'

SignatureCapture = React.createFactory require './signaturecapture'

{ div, h1, button } = React.DOM

UI = React.createClass
  displayName: 'UI'

  getInitialState: ->
    signatureData: null

  render: ->
    div null,
      h1 null, 'Signature Capture'

      SignatureCapture
        data: @state.signatureData
        onChange: @_signatureChange

      button onClick: (_.bind @_signatureChange, null, null), 'Reset'

  _signatureChange: (data) ->
    @setState signatureData: data

module.exports = UI
