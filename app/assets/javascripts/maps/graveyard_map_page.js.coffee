root = (exports ? this)

root.GraveyardMapPage = class GraveyardMapPage
  constructor: (@options) ->
    if @options.url
      this.loadAndDisplay(@options.url)

  loadAndDisplay: (url) ->
    @locations = new GraveLocationsCollection(this)
    @locations.fetch url, => this.onDataLoaded()

  onDataLoaded: ->
    this.createSelector()
    this.createMap()

  createMap: ->
    @map = new GraveyardMap(this, @options)
    @map.addLocations(@locations)
    @map.draw()

  createSelector: ->
    @selector = new GraveyardLocationSelector(this)
    @selector.addLocations(@locations)
