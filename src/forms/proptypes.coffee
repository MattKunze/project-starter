PropTypes = {}

PropTypes.InputShape =
  type: React.PropTypes.oneOf([
    'text'
    'number'
  ]).isRequired
  placeholder: React.PropTypes.string

PropTypes.FormItemShape = Object.assign
  label: React.PropTypes.string
,
  PropTypes.InputShape

module.exports = PropTypes
