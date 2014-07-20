# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = (exports ? this)

root.PhotoUploader = class PhotoUploader
  constructor: (@$form)->
    @count = 0
    self=this

    @$form.fileupload
      dataType: 'json'
      add: (e, data) ->
        file = data.files[0]
        self.count = self.count + 1

        data.context = $(tmpl('template-upload', file))
        $('#upload-display').prepend(data.context)
        data.submit()

        caption = "Drop photos here (" + (self.count) + " submitted)"
        $('.fileinput-button label').text(caption)

      progress: (e, data) ->
        if data.context
          if data.total > 0
            progress = parseInt(data.loaded / data.total * 100, 10)
            data.context.find('.bar').css('width', ''+progress + '%')

