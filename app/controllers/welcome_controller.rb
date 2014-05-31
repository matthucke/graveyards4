class WelcomeController < ApplicationController
  def index
    @breadcrumbs.hidden=true
    self.page_title ="Graveyards.com - Graveyards of Illinois - since 1996"
  end
end
