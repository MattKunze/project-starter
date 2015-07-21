module.exports = (url, transform) ->
  new Promise (resolve, reject) ->
    fetch url
      .then (results) ->
        if results.status isnt 200
          reject new Error results.statusText
        else
          results.json()
            .then (json) ->
              resolve transform json
      .catch reject
