React = require 'react'
_ = require 'lodash'

{ div } = React.DOM

AppLayout = React.createClass
  displayName: 'AppLayout'

  propTypes:
    updateMessage: React.PropTypes.func.isRequired

  getInitialState: ->
    collapsed: false

  componentDidMount: ->
    window.addEventListener 'scroll', @_onScroll
    document.addEventListener 'touchstart', @_onTouchStart
    document.addEventListener 'touchmove', @_onTouchMove

    @_resetScroll = _.debounce ->
      if not @state.collapsed and window.scrollY > 0
        window.scrollTo 0, 0
    , 100

  render: ->
    ios = navigator.userAgent.match /i(Phone|Pod|Pad)/i
    android = navigator.userAgent.match /Android/i
    div null,
      @props.children
      if ios or android
        Treadmill
          height: window.innerHeight if @state.collapsed

  _onScroll: (ev) ->
    collapsed = @_isCollapsed()
    if collapsed isnt @state.collapsed
      @setState { collapsed }

    landscape = window.innerHeight < window.innerWidth
    # screen sizes don't reflect orientation
    screenHeight = if landscape
      window.screen.width
    else
      window.screen.height
    message = "Scroll: #{window.scrollY} -
      Inner/screen: #{window.innerHeight}/#{screenHeight}
      Landscape: #{landscape}
      #{screenHeight - window.innerHeight} -> #{@state.collapsed}"
    @props.updateMessage message
    console.log message

    @_resetScroll()

  _onTouchStart: (ev) ->
    @_touchStartY = ev.touches[0].screenY

  _onTouchMove: (ev) ->
    if @state.collapsed and ev.touches[0].screenY < @_touchStartY
      ev.preventDefault()

  _isCollapsed: ->
    landscape = window.innerHeight < window.innerWidth
    # screen sizes don't reflect orientation
    screenHeight = if landscape
      window.screen.width
    else
      window.screen.height
    (screenHeight - window.innerHeight) < 60

Treadmill = React.createFactory React.createClass
  displayName: 'Treadmill'

  propTypes:
    height: React.PropTypes.number.isRequired

  getDefaultProps: ->
    height: 10000

  render: ->
    div
      className: 'treadmill'
      style:
        visibility: 'hidden'
        position: 'absolute'
        top: 0
        height: "#{@props.height}px"
        width: '1px'

module.exports = AppLayout
