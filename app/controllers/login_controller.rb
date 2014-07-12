class LoginController < ApplicationController
  def index
    @page_title="Log In"
    render_with_selected_layout
  end

end
