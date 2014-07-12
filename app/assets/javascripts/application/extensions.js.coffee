
# Extend jquery.
( ($)->
    # get classes as list
    $.fn.classes = ->
      klass = this.attr('class')
      if klass then klass.split(/\s+/) else []

)(jQuery)

