
root = (exports ? this)

root.GraveyardMap = class GraveyardMap
  constructor: (@parent, @options) ->
    @$map = $('#' + @options.mapId)
    this.resizer = new GraveyardMapSizer(@$map)

  addLocations: (@locations) ->
    console.log("adding locations")
    console.dir(@locations)

  googleMap: ->
    unless @the_map
      @the_map = new google.maps.Map(
        this.$map[0],
        zoom: 10
        mapTypeId: google.maps.MapTypeId.ROADMAP
      )

    @the_map

  draw: ->
    map=this.googleMap()
    this.plotLocation(loc) for loc in this.locations.locations
    this.setBounds(this.locations.bounds())
    map.setCenter(@bounds.getCenter())

  plotLocation: (loc) ->
    m = this.makeMarker(loc)

  makeMarker: (loc) ->
    ll = loc.toLatLng()
    return null if !ll

    m = new google.maps.Marker
      position: ll
      visible: true
      clickable: true
      map: this.googleMap()
      title: loc.name
    loc.marker=m
    return m



  setBounds: (bounds) ->
    @bounds=bounds
    console.log("bounds")
    console.dir(bounds)