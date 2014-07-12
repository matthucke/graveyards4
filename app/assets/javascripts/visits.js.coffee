
root = (exports ? this)

root.VisitLogger = class VisitLogger extends AjaxForm
  constructor: (@link) ->
    @$link= $(link)
    @$cell = @$link.parents('.cell')
    @graveyard_id = @$cell.attr('data-location-id')

    window.VISITOR = this # FIXME

  handleClick: ->
    unless (@graveyard_id)
      alert("cannot determine graveyard ID from document structure, sorry")
      return false

    url = null
    if @$cell.hasClass('visits-none')
      url = "/visits/new?visit[graveyard_id]=#{@graveyard_id}&layout=modal"
    else
      url = "/visits/0/edit?graveyard_id=#{@graveyard_id}&layout=modal"

    new ModalLoader(url).fetch
      callback: (modal) => this.onDisplay(modal)

  onDisplay: (@modal) ->
    self=this

    this.$form = modal.$modal.find('form:first')

    @$datepicker = this.$form.find('.datepicker').datepicker(
      dateFormat: 'yy-mm-dd'
      changeMonth: true,
      changeYear: true,
    )

    this.$form.find('.use-date').click (evt) ->
      evt.preventDefault() if evt && evt.preventDefault
      self.useDate($(this).text())

    this.bindSubmit()

    this.deleteWidget = new DeleteVisitWidget(this)

  useDate: (d) ->
    if d == 'clear date' || d == ''
      @$datepicker.val('')
    else
      @$datepicker.val(d)


  handleSuccess: (visit) ->
    if (@modal)
      @modal.hide()

    this.updateStatusDisplay(visit.status, visit.caption)

  updateStatusDisplay: (status, caption) ->
    @$cell.removeClass('visits-visited visits-none visits-todo')
    if status
      @$cell.addClass("visits-#{status}")
      @$link.attr('title', caption) if caption
    else
      alert('no visit status')



root.VisitLogger.bindAll = ->
  $links = $('.visit-details')
  if $links.length > 0
    $links.click (evt) ->
      evt.preventDefault() if evt && evt.preventDefault
      new VisitLogger(this).handleClick()


# DELETER #
root.DeleteVisitWidget = class DeleteVisitWidget  extends AjaxForm
  constructor: (@parent) ->
    this.$form = $('#delete-visit')
    if 0 ==  this.$form.length
      return
    this.bindForm()
    this.confirmChanged()
    window.DELETER=this

  bindForm: ->
    @$confirm = $('#confirm-delete-visit').change => this.confirmChanged()
    this.bindSubmit()

  confirmChanged: ->
    c = @$confirm.prop('checked')
    @$submit = this.$form.find('.btn')
    if (c)
      @$submit.removeAttr('disabled')
    else
      @$submit.attr('disabled', true)

  handleSuccess: (@response, status, response_header) ->
    if this.parent
      this.parent.modal.hide() if this.parent.modal
      this.parent.updateStatusDisplay('none', "You have not visited this location")
    else
      alert("Deleted")