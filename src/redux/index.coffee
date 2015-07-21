{ applyMiddleware, combineReducers, createStore } = require 'redux'
thunk = require 'redux-thunk'

promiseMiddleware = require './promisemiddleware'
organizationReducer = require './organizationreducer'
userReducer = require './userreducer'

finalCreateStore = (applyMiddleware thunk, promiseMiddleware) createStore
module.exports = finalCreateStore combineReducers
  organization: organizationReducer
  user: userReducer
