module.exports = (accessToken, url, transform) ->
  new Promise (resolve, reject) ->
    fetch url, headers: { Authorization: "token #{accessToken}"}
      .then (results) ->
        if results.status isnt 200
          reject new Error results.statusText
        else
          results.json()
            .then (json) ->
              resolve transform json
      .catch reject
