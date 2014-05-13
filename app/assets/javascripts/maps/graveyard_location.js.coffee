
root = (exports ? this)

root.GraveyardLocation = class GraveyardLocation
  constructor: (stuff) ->
    if (stuff)
      $.extend(this, stuff)

  toLatLng: ->
    unless @_ll
      return null if isNaN(@lat) || isNaN(@lng)
      return null if Math.abs(@lat) < 0.01 && Math.abs(@lng) < 0.01

      @_ll = new google.maps.LatLng(@lat, @lng)
    @_ll

