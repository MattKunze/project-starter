{ Actions } = require '../constants'
doFetch = require '../utils/dofetch'

UserActions =

  loadUser: (login) ->
    type: Actions.LOAD_USER
    promise: doFetch "https://api.github.com/users/#{login}/gists", (json) ->
      _.map json, (gist) ->
        _.pick gist, 'id', 'url', 'description'

module.exports = UserActions
