#
# Global functionality on every page of site.
#
root = (exports ? window)

root.GraveyardsComPage = class GraveyardsComPage
  constructor: ->

  init: ->
    this.initNavbar()

  initNavbar: ->
    $n = $('#main-navbar')

    # uses https://github.com/istvan-ujjmeszaros/bootstrap-autohidingnavbar.git
    if ($n.autoHidingNavbar)
      $n.autoHidingNavbar()

    if (window.LoginLink)
      window.LoginLink.bindAll()
