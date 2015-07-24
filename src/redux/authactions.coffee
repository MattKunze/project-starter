queryString = require 'querystring'

{ Actions } = require '../constants'

verifyToken = (token) ->
  new Promise (resolve, reject) ->
    fetch "https://api.github.com/user?access_token=#{token}"
      .then (response) ->
        response.json()
      .then (json) ->
        if json.login
          resolve()
        else
          reject()

AuthActions =
  checkAuthorization: ->
    (dispatch) ->
      token = localStorage.getItem 'access_token'
      verifyToken token
        .then ->
          console.warn "authenticated #{token}"
          dispatch type: Actions.ACCESS_TOKEN, payload: token

  saveToken: (token) ->
    (dispatch) ->
      console.warn "save token: #{token}"
      verifyToken token
        .then ->
          localStorage.setItem 'access_token', token
          location.href = '/'

module.exports = AuthActions
