# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = (exports ? this)

class root.PhotoUploader
  constructor: (@$form)->
    @count = 0
    this.enableUpload()
    this.bindForm()

  bindForm: ->
    @$form.on 'submit', ->
      alert("no")
      return false

  enableUpload: ->
    self=this
    @$form.fileupload
      dataType: 'json'
      add: (e, data) ->
        file = data.files[0]

        data.context = $(tmpl('template-upload', file))
        $('#upload-display').prepend(data.context)

        data.submit()
        self.afterSubmit(data)

      progress: (e, data) ->
        if data.context
          if data.total > 0
            progress = parseInt(data.loaded / data.total * 100, 10)
            data.context.find('.bar').css('width', ''+progress + '%')

  afterSubmit: (data) ->
    this.updateLabel()
    this.updateSortOrder()

  # Label in the file drop area.
  updateLabel: ->
    @count = @count + 1
    $('.fileinput-button label').text "Drop photos here (" + (@count) + " submitted)"

  # add 100 to whatever's in sort order field
  updateSortOrder: ->
    $s = $('#photo_sort_order')
    val = $s.val()
    unless isNaN(val)
      $s.val(100 + (+val))


