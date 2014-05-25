root = (exports ? this)

# This is the widget that presents a list of graveyards (a UL element)
# and lets user pick.
root.GraveyardLocationSelector = class GraveyardLocationSelector
  constructor: (@parent, @map) ->
    @element = $('#location-selector')
    @contents=[]
    $('#selector-wrapper').draggable()

  addLocations: (@collection) ->
    this.addItem(this.createItem(loc)) for loc in @collection.locations

  createItem: (loc) ->
    new GraveyardLocationSelectorItem(loc, this)

  addItem: (item) ->
    @contents.push item
    this.element.append item.element
