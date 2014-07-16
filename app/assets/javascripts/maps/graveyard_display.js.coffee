root = (exports ? this)


root.GraveyardDisplay = class GraveyardDisplay
  constructor: (@location, @map) ->
    return unless @location.isLocated()
    unless window.graveyardDisplayTemplate
      this.initTemplate()
    @marker = this.makemarker()
    @infowindow = this.makeInfoWindow();
    this.bindMarkerClick()

  makemarker: ->
    gmap = @map.googleMap()

    # This only works if the entire markerwithlabel declaration is done on ready(),
    # wrapped in a function, with window.MarkerWithLabel = MarkerWithLabel; at the end.
    # Otherwise it can't inherit properly and fails silently.
    # m = new google.maps.Marker
    sn = @location.shortName()
    m = new MarkerWithLabel
      position: @location.toLatLng()
      # map: gmap
      title: @location.name
      icon: this.iconForLocation()
      visible: true
      clickable: true
      # draggable: true
      labelContent: @location.shortName()
      # labelAnchor: new google.maps.Point( (sn.length * 6) / 2, 0)
      labelAnchor: new google.maps.Point( 30, 0)
      labelClass: 'labels'
      labelStyle: {  }

    m.setMap(gmap)
    m

  iconForLocation: ->
    v = @location.visit
    if v
      if v.status == 'todo'
        return '/images/pushpins/yellow.png'
      else
        return '/images/pushpins/blue.png'
    return '/images/pushpins/red.png'

  makeInfoWindow: ->
    w = new google.maps.InfoWindow
      content: window.graveyardDisplayTemplate(@location)

  bindMarkerClick: ->
    google.maps.event.addListener @marker, 'click', =>
      @infowindow.open(@map.googleMap(), @marker)

  initTemplate: ->
    text = $('#info-window-template').html()
    window.graveyardDisplayTemplate = Handlebars.compile(text)