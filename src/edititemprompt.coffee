{ InputItemShape } = require './forms/proptypes'

DynamicForm = React.createFactory require './forms/dynamicform'
createValueBinding = require './forms/createvaluebinding'

{ div, h4, button } = React.DOM
cx = require 'classnames'

EditItemPrompt = React.createClass
  displayName: 'EditItemPrompt'

  propTypes:
    item: (React.PropTypes.shape InputItemShape).isRequired
    updateItem: React.PropTypes.func.isRequired
    onCancel: React.PropTypes.func.isRequired

  componentWillMount: ->
    createBinding = (key) =>
      createValueBinding
        get: => @state.updated[key]
        set: (value) =>
          @state.updated[key] = value

    @setState
      updated: Object.assign {}, @props.item
      formItems: [
        type: 'text'
        label: 'Key'
        value: createBinding 'key'
      ,
        type: 'text'
        label: 'Label'
        value: createBinding 'label'
      ,
        type: 'list'
        label: 'Type'
        value: createBinding 'type'
      ]

  render: ->
    div className: 'modal', style: { display: 'block' },
      div className: 'modal-dialog',
        div className: 'modal-content',
          div className: 'modal-body',
            DynamicForm items: @state.formItems
          div className: 'modal-footer',
            button className: 'btn btn-default', onClick: @props.onCancel,
              'Cancel'
            button className: 'btn btn-primary', onClick: @_updateItem,
              'OK'

  _updateItem: ->
    @props.updateItem @state.updated

module.exports = EditItemPrompt
