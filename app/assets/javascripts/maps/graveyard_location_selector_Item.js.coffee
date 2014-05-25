root = (exports ? this)

root.GraveyardLocationSelectorItem = class GraveyardLocationSelectorItem
  constructor: (@location, @parent) ->
    @map = @parent.map
    this.element = this.buildElement()
    this.bindLink(@link)

  buildElement: ->
    $li = $('<li>')
    if @location.toLatLng()
      $li.addClass('located')
    else
      $li.addClass('not-located')

    @link = $('<a>').attr('href', @location.url).attr('id', "link-" + @location.id).text(
      @location.name
    )
    $li.append(@link)
    $li

  bindLink: (link) ->
    link.click (evt) => this.handleClick(evt)

  handleClick: (evt) ->
    evt.preventDefault()
    if @location && @location.isLocated()
      if @map
        @map.zoomToLocation(@location)
        @map.openLocation(@location)
      else
        alert("ERROR NO MAP")
    else
      alert("The exact location of this cemetery is unknown.")
