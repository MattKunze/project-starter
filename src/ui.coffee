require 'normalize.css'
require 'bootstrap/less/bootstrap.less'
require 'bootstrap/less/theme.less'

{ div, h1, p } = React.DOM

DynamicForm = React.createFactory require './forms/dynamicform'

UI = React.createClass
  displayName: 'UI'

  render: ->
    div null,
      h1 null, 'Dynamic Form Playground'

      div className: 'container',
        DynamicForm
          items: [
            type: 'text'
            label: 'Text?'
            placeholder: 'Something'
          ,
            type: 'number'
            label: 'Integer'
            placeholder: '42'
          ]

module.exports = UI
