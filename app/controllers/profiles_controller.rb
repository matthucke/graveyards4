class ProfilesController < ApplicationController

  def show
    return redirect_to '/' unless current_user

  end

end
