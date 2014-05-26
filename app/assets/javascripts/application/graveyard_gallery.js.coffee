root = (exports ? this)

root.GraveyardGallery = class GraveyardGallery
  constructor: (@image_data) ->
    @thumbs = $('a.thumb')
    @mainImage = $('#main-image')
    this.buildGallery()

  buildGallery: ->
    if @thumbs.length < 1
      return null

    self=this
    @thumbs.click (evt) ->
      evt.preventDefault()
      self.handleClick $(this)

  handleClick: ($link) ->
    @mainImage.attr('src', $link.attr('href'))