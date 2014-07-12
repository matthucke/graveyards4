
# Invoked thus:
#     new ModalLoader("/login/?layout=modal").fetch()
#     new ModalLoader("/login/?layout=modal").fetch({ callback: myfunction })
root = (exports ? this)

root.ModalLoader = class ModalLoader
  constructor: (@url) ->

  fetch: (opts) ->
    opts ||= {}
    $.get @url, {}, (response) => this.display(response, opts)

  display: (response, opts) ->
    opts ||= {}
    @$modal = $(response)

    this.append_to_document(response, opts)

    @$modal.modal()

    if cb = opts.callback
      (cb)(this)

  hide: ->
    @$modal.modal('hide')

  append_to_document: (response, opts) ->
    # kill previous one, if any.
    $('#modal-container').remove()

    @$container = $('<div id="modal-container">').append(@$modal);
    $('body').prepend(@$container)



