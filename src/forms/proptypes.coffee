PropTypes = {}

PropTypes.ValueBindingShape =
  get: React.PropTypes.func.isRequired
  change: React.PropTypes.func.isRequired
  accept: React.PropTypes.func.isRequired
  readOnly: React.PropTypes.bool
  required: React.PropTypes.bool
  dirty: React.PropTypes.bool

PropTypes.InputShape =
  type: React.PropTypes.oneOf([
    'text'
    'number'
  ]).isRequired
  placeholder: React.PropTypes.string
  value: (React.PropTypes.shape PropTypes.ValueBindingShape).isRequired

PropTypes.FormItemShape = Object.assign
  label: React.PropTypes.string
,
  PropTypes.InputShape

module.exports = PropTypes
