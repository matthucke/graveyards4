root = (exports ? this)

root.GraveyardLocationSelector = class GraveyardLocationSelector
  constructor: (@parent) ->
    @list = $('#location-selector')

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
    $li.find('a').click (evt) -> self.handleClick($(this), evt)

  handleClick: ($link, evt) ->
    evt.preventDefault()
    alert("you click'd upon " + $link.attr('id'))