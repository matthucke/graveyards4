root = (exports ? this)

root.GraveyardLocationSelector = class GraveyardLocationSelector
  constructor: (@parent) ->
    @list = $('#location-selector')
    $('#selector-wrapper').draggable()

  addLocations: (@collection) ->
    this.addItem(loc) for loc in @collection.locations

  addItem: (loc) ->
    $li = this.buildListItem(loc)
    this.list.append($li)
    this.bindItem($li, loc)

  buildListItem: (loc) ->
    $li = $('<li>')
    if loc.lat && loc.lng
      $li.addClass('located')
    else
      $li.addClass('not-located')

    $a = $('<a>').attr('href', loc.url).attr('id', "link-" + loc.id).text(
      loc.name
    )
    $li.append($a)


  bindItem: ($li, loc) ->
    self=this
    $link = $li.find('a')
    if $link[0]
      $link[0].grave_location = loc;
      $link.click (evt) -> self.handleClick($link, evt, loc)

  handleClick: ($link, evt, loc) ->
    evt.preventDefault()
    alert("you click'd upon " + $link.attr('id'))
    if !loc
      if a=$link[0]
        loc=a.grave_location
    if !loc
      alert("cannot ascertain grave location from link")
    if @parent.map
      @parent.map.panTo(loc)
