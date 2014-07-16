
root = (exports ? this)

root.GraveyardMap = class GraveyardMap
  constructor: (@parent, @options) ->
    @$map = $('#' + @options.mapId)
    this.resizer = new GraveyardMapSizer(@$map)


  addLocations: (locations) ->
    @locations=locations

  googleMap: ->
    unless @the_map
      @the_map = new google.maps.Map(
        this.$map[0],
        zoom: 10
        mapTypeId: google.maps.MapTypeId.ROADMAP
      )
    window.THE_MAP = @the_map

    @the_map

  panToLocation: (loc) ->
    this.panToPoint(loc.toLatLng())

  panToMarker: (marker) ->
    this.panToPoint(marker.position)

  panToPoint: (latlng) ->
    this.googleMap().panTo(latlng)

  zoomToLocation: (loc) ->
    this.panToLocation(loc)
    if @the_map.getZoom() < 12
      @the_map.setZoom(12)

  openLocation: (location) ->
    #//alert("open " + location.name)

  draw: ->
    map=this.googleMap()
    this.plotLocation(loc) for loc in this.locations.locations
    this.setBounds(this.locations.bounds())
    map.setCenter(@bounds.getCenter())

  plotLocation: (loc) ->
    loc.marker = new GraveyardDisplay(loc, this)

  setBounds: (bounds) ->
    @bounds=bounds
