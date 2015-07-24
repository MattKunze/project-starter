_ = require 'lodash'
https = require 'https'
queryString = require 'querystring'

module.exports = (oauth) ->
  (req, res) ->
    { code } = req.query
    data = queryString.stringify _.assign { code }, oauth
    console.warn "authenticating #{data}"

    options =
      host: 'github.com'
      port: 443
      path: '/login/oauth/access_token'
      method: 'POST'
      headers:
        accept: 'application/json'
        'content-length': data.length

    auth = https.request options, (authRes) ->
      body = ''

      authRes.on 'data', (chunk) -> body += chunk
      authRes.on 'end', ->
        console.warn "received #{body}"
        json = JSON.parse body
        if json.access_token
          res.redirect "/#auth/#{json.access_token}"
        else if json.error
          res.status(401).send json
        else
          res.status(400).send error: 'Unknown error'

    auth.write data
    auth.end()
    auth.on 'error', (error) ->
      console.error error
