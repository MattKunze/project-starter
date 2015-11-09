module.exports = ({ get, set }) ->
  pendingValue = undefined
  acceptPromise = null
  validationError = null

  binding =
    isDirty: -> pendingValue isnt undefined
    isValidating: -> acceptPromise?
    getValidationError: -> validationError
    get: ->
      if binding.isDirty()
        pendingValue
      else
        get()
    change: (value) ->
      pendingValue = value
    accept: =>
      return Promise.resolve() unless binding.isDirty()
      return acceptPromise if binding.isValidating()
      validationError = null
      acceptPromise = new Promise (resolve, reject) ->
        Promise.resolve set pendingValue
          .then ->
            acceptPromise = null
            binding.cancel()
            resolve()
          .catch (error) ->
            acceptPromise = null
            validationError = error
            reject error
    cancel: ->
      pendingValue = undefined
      validationError = null
