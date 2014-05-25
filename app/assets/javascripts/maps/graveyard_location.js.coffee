
root = (exports ? this)

# Attributes of graveyard as passed to us by json - lat, lng, name, url, id...
root.GraveyardLocation = class GraveyardLocation
  constructor: (attrs) ->
    if (attrs)
      $.extend(this, attrs)

  isLocated: ->
    if this.toLatLng() then true else false

  toLatLng: ->
    unless @_ll
      return null if isNaN(@lat) || isNaN(@lng)
      return null if Math.abs(@lat) < 0.01 && Math.abs(@lng) < 0.01

      @_ll = new google.maps.LatLng(@lat, @lng)
    @_ll

