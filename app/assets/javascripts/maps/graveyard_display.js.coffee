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
    m = new google.maps.Marker
      position: @location.toLatLng()
      map: @map.googleMap()
      title: @location.name
      icon: this.iconForLocation()
      visible: true
      clickable: true
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
    console.log("init template")
    text = $('#info-window-template').html()
    window.graveyardDisplayTemplate = Handlebars.compile(text)