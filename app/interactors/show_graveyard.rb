class ShowGraveyard
  include Interactor

  def call
    if g=self.graveyard
      context.graveyard=g.decorate
    end
    fail unless context.graveyard
  end

  def redirect?
    !!context.redirect
  end

  def graveyard
    g = finder.graveyard
    return g if g

    # Found using a sloppy path match?
    if g = alternate_finder.graveyard
      # YES, happy, but we must redirect
      context.redirect = true
    end
    g
  end

  def finder
    @finder ||= GraveyardPathResolver.new(context.params)
  end

  def alternate_finder
    @alternate_finder ||= GraveyardAlternatePathResolver.new(context.params)
  end

end
