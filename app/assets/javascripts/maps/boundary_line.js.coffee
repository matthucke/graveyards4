root = (exports ? this)

# Add a county boundary to the map via polyline encoder.
root.BoundaryLine = class BoundaryLine
  constructor: (@parent, @encoded_points) ->

  draw: (@map) ->
    if @encoded_points
      try
        @line = this.createPolyLine(@encoded_points)
        @line.setMap(mapPage.map.googleMap())
      catch ex
        console.log(ex)
    return this


  createPolyLine: (encoded) ->
    decoded_path = google.maps.geometry.encoding.decodePath(encoded)

    path_options = {
      path: decoded_path,
      strokeColor: "#000000",
      strokeOpacity: 0.5,
      strokeWeight: 4
    }
    return new google.maps.Polyline(path_options)

    #@map.addOverlay(@line)


