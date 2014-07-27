class LoginController < ApplicationController
  def index
    @page_title="Log In"

    if return_to = (params[:return_to] || request.env["HTTP_REFERER"])
      session[:return_to] = URI(return_to).path rescue nil
    end

    render_with_selected_layout
  end

end
