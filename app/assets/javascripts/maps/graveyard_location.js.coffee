
root = (exports ? this)

root.GraveyardLocation = class GraveyardLocation
  constructor: (stuff) ->
    if (stuff)
      $.extend(this, stuff)

  toLatLng: ->
    return null if isNaN(@lat) || isNaN(@lon)

    return null if Math.abs(@lat) < 0.01 && Math.abs(@lon) < 0.01

    new google.maps.LatLng(@lat, @lon)
