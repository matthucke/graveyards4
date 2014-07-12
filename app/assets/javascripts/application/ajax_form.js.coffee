root = (exports ? this)

root.AjaxForm = class AjaxForm
  constructor: (@$form) ->
    # usually not called, will be overridden!

  bindSubmit: ->
    this.$form.submit (evt) =>
      evt.preventDefault() if evt && evt.preventDefault
      this.formSubmit()

  toParams: ->
    @$form.serializeArray()

  beforeSubmit: ->
    this.showErrors(null)
    true

  showErrors: (@error_hash) ->
    $target=$('#message-area')
    $target.empty()

    return if error_hash == null

    for k, v of error_hash
      $msg = $('<div class="error">')
      $msg.append( $('<strong>').text( _.humanize(k)) )
      $msg.append( $('<span>').text(' ' + v))
      $target.append($msg)

  formSubmit: ->
    try
      @url = @url || @$form.attr('action') + '.json'
      return if false == this.beforeSubmit()

      $.ajax @url, {
        type: 'post'
        data: this.toParams(),
        success: (response, status, xhr) =>
          this.handleSuccess(response, status, xhr)
        error: (response, status, message) =>
          this.handleError(response, status, message)
      }

      # important! must return false to prevent normal submit.
      return false
    catch err
      alert(err)
      return true

  # override this.
  handleSuccess: (@response) ->
    alert("Success.")

  handleError: (response, textStatus, message) ->
    errs= response.responseJSON
    if errs && !_.isEmpty(errs)
      this.showErrors(errs)
    else
      this.showErrors({ error : [ message ? message : "unknown" ] })


