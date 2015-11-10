{ FormItemShape } = require './proptypes'
FormItem = React.createFactory require './formitem'

{ form } = React.DOM

DynamicForm = React.createClass
  displayName: 'DynamicForm'

  propTypes:
    items: (React.PropTypes.arrayOf React.PropTypes.shape FormItemShape).isRequired

  render: ->
    form className: 'form-horizontal', onSubmit: @_noop,
      for item, index in @props.items
        FormItem Object.assign key: index, item

  _noop: (ev) ->
    ev.preventDefault()
    
module.exports = DynamicForm
