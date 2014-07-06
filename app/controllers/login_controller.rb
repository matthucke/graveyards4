class LoginController < ApplicationController
  def index
    @page_title="Log In"
    render layout: safe_layout
  end

private
  def safe_layout
    l = params[:layout] or return false
    layouts = [ 'application', 'modal']
    return layouts.index(l) ? l : false
  end
end
