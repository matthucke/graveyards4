class WelcomeController < ApplicationController
  def index
    @breadcrumbs.hidden=true
  end
end
