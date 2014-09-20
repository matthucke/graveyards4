class ShowGraveyard
  include Interactor

  def call
    context.graveyard=self.graveyard
    fail unless context.graveyard
  end

  def redirect?
    !!context.redirect
  end

  def graveyard
    g = finder.graveyard
    unless g
      # Found using a sloppy path match?
      if g = alternate_finder.graveyard
        # YES, happy, but we must redirect
        context.redirect = true
      end
    end
    g
  end

  def finder
    @finder ||= GraveyardPathResolver.new(context.params)
  end

  def finder
    @alternate_finder ||= GraveyardAlternatePathResolver.new(context.params)
  end

end
