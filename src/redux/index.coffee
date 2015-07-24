{ applyMiddleware, combineReducers, createStore } = require 'redux'
thunk = require 'redux-thunk'

fetchMiddleware = require './fetchMiddleware'
promiseMiddleware = require './promisemiddleware'
organizationReducer = require './organizationreducer'
userReducer = require './userreducer'

middleware = applyMiddleware thunk, fetchMiddleware, promiseMiddleware
finalCreateStore = middleware createStore
module.exports = finalCreateStore combineReducers
  organization: organizationReducer
  user: userReducer
