
root = (exports ? this)

root.VisitLogger = class VisitLogger
  constructor: (@link) ->
    @$link= $(link)
    @$cell = @$link.parents('.cell')
    @graveyard_id = @$cell.attr('data-location-id')

    window.VISITOR = this # FIXME

  handleClick: ->
    unless (@graveyard_id)
      alert("cannot determine graveyard ID from document structure, sorry")
      return false

    if @$cell.hasClass('visited')
      alert("FIX ME: handle already-visited sites")
    else
      url = "/visits/new?visit[graveyard_id]=#{@graveyard_id}&layout=modal"
      new ModalLoader(url).fetch()




root.VisitLogger.bindAll = ->
  $links = $('.visit-details')
  if $links.length > 0
    $links.click (evt) ->
      evt.preventDefault() if evt && evt.preventDefault
      new VisitLogger(this).handleClick()

