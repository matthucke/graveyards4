# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = (exports ? this)

root.PhotoUploader = class PhotoUploader
  constructor: (@$form)->
    console.log("building...")

    @$form.fileupload
      dataType: 'json'
      add: (e, data) ->
        console.log("this is ADD, fl= " + data.files.length)
        window.FZERO = data.files[0]

        file = data.files[0]
        console.dir(file)

        data.context = $(tmpl('template-upload', file))
        $('#upload-display').append(data.context)
        data.submit()

      progress: (e, data) ->
        if data.context
          if data.total > 0
            progress = parseInt(data.loaded / data.total * 100, 10)
            data.context.find('.bar').css('width', ''+progress + '%')

    console.dir("CONS DONE")
