
#
# A list of graveyards, typically in a single county,
# and the logic for fetching it from the server.
#
root = (exports ? this)

root.GraveLocationsCollection = class GraveLocationsCollection
  constructor: (@parent) ->
    @locations = []

  # Get from server, set into self, then invoke callback that lets the
  # GraveyardMapPage know about this.
  fetch: (url, callback) ->
    $.get url, {}, (response) =>
      this.loadFromJson(response)
      if (callback)
        (callback)(this)

  loadFromJson: (response) ->
    if response.status == 'success'
      @success = true
    else
      @success = false
      alert("Unsuccessful in loading graveyard locations from server.")

    if response.locations
      this.addAll(response.locations)


  addAll: (list) ->
    this.add(loc) for loc in list

  add: (raw_loc) ->
    location = new GraveyardLocation(raw_loc)
    @locations.push(location)

  # Calculate bounding box.
  bounds: ->
    if ! @_bounds
      @_bounds = new google.maps.LatLngBounds();

    for loc in this.locations
      ll = loc.toLatLng()
      if ll
        @._bounds.extend(ll)

    @_bounds
