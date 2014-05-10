class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :breadcrumb_init

protected

  def breadcrumb_init
    @breadcrumbs = BreadcrumbTrail.new(request)
  end

  def page_title=(t)
    @page_title=t
    @breadcrumbs.here.title=t
  end

  def require_admin
    raise "admin login not supported yet"
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
