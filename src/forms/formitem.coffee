{ FormItemShape } = require './proptypes'

TextInput = React.createFactory require './textinput'
NumericInput = React.createFactory require './numericinput'

{ div, label } = React.DOM

FormItem = React.createClass
  displayName: 'FormItem'

  propTypes: Object.assign
    labelColumns: React.PropTypes.number.isRequired
  , FormItemShape

  getDefaultProps: ->
    labelColumns: 2

  render: ->
    controlColumns = if @props.label
      12 - @props.labelColumns
    else
      12

    div className: 'form-group has-feedback has-warning',
      if @props.label
        label className: "control-label col-sm-#{@props.labelColumns}",
          @props.label
      div className: "col-sm-#{controlColumns}",
        switch @props.type
          when 'text'
            TextInput @props
          when 'number'
            NumericInput @props

module.exports = FormItem
