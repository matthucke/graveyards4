class ShowGraveyard
  include Interactor

  def call
    @finder = GraveyardPathResolver.new(context.params)

    context.graveyard = Graveyard.first
  end
end
