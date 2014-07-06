# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = (exports ? this)

root.LoginLink = class LoginLink
  constructor: (@$link) ->
    @$link.click (evt) =>
      evt.preventDefault() if evt && evt.preventDefault
      new ModalLoader("/login/?layout=modal").fetch()


root.LoginLink.bindAll = ->
    $links = $('.login-link')
    if $links.length > 0
      new LoginLink($links)

