class ShowGraveyard
  include Interactor

  def call
    if g=self.graveyard
      context.graveyard=g.decorate
    end
    context.fail! unless context.graveyard
    context
  end

  def redirect?
    !!context.redirect
  end

  def graveyard
    # Numeric graveyard Id>
    id = context.params[:id]
    if id.to_i > 0
      context.redirect=true
      return Graveyard.find(id)
    end

    # else, handle ordinary path...
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
