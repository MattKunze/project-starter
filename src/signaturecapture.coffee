React = require 'react'
SignaturePad = require 'signature_pad'

{ canvas, div } = React.DOM

SignatureCapture = React.createClass
  displayName: 'SignatureCapture'

  propTypes:
    data: React.PropTypes.string
    onChange: React.PropTypes.func.isRequired

  componentDidMount: ->
    @_signaturePad = new SignaturePad (@getDOMNode().querySelector 'canvas'),
      onEnd: =>
        @_currentData = @_signaturePad.toDataURL()
        @props.onChange @_currentData

    @_signaturePad.fromDataURL @props.data if @props.data
    @_resize()

    window.addEventListener 'resize', @_resize

  componentDidUpdate: ->
    if @props.data isnt @_currentData
      if @props.data
        @_signaturePad.fromDataURL @props.data
      else
        @_signaturePad.clear()

  componentWillUnmount: ->
    window.removeEventListener 'resize', @_resize

  render: ->
    div
      className: 'signature-capture'
      style:
        position: 'relative'
    ,
      div
        className: 'signing-line'
        style:
          position: 'absolute'
          left: '5%'
          right: '5%'
          bottom: '20%'
          border: '1px solid #ccc'
      canvas
        className: 'signature-capture'
        height: '300px'
        style:
          border: '1px solid black'

  _resize: ->
    node = @getDOMNode()
    el = node.querySelector 'canvas'
    el.width = node.clientWidth - 2

module.exports = SignatureCapture
