
root = (exports ? this)

root.ModalLoader = class ModalLoader
  constructor: (@url) ->

  fetch: ->
    $.get @url, {}, (response) => this.display(response)

  display: (response) ->
    @$modal = $(response);

    $('#modal-container').remove()
    $c = $('<div id="modal-container">').append(@$modal);
    $('body').prepend($c)
    @$modal.modal()

