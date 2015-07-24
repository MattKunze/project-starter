{ Actions } = require '../constants'
doFetch = require '../utils/dofetch'

UserActions =

  loadUser: (login) ->
    type: Actions.LOAD_USER
    fetch:
      url: "https://api.github.com/users/#{login}/gists"
      transform: (json) ->
        _.map json, (gist) ->
          _.pick gist, 'id', 'url', 'description'

module.exports = UserActions
