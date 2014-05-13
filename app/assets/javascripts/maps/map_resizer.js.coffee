#
# Resize $map (passed to us by GraveyardMap) when the window resizes.
# Do this once on create and on any window.resize() event.
#
root = (exports ? this)

root.GraveyardMapSizer = class GraveyardMapSizer
  constructor: (@$map) ->
    this.resize()
    $(window).on 'resize', => this.resize()

  resize: ->
    window_height = $(window).height()
    map_top = this.$map.position().top;
    map_height = Math.floor window_height - map_top - 8
    console.dir("new height " + map_height)
    this.$map.css 'height', map_height + "px"
    map_height
