class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :breadcrumb_init, :current_user

  attr_accessor :breadcrumbs

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

  def current_user
    unless @current_user
      if ident=identity
        @current_user = ident.user
      end
    end
    @current_user
  end

  def identity
    unless @identity
      if iid = session[:identity_id]
        @identity = Identity.find(iid) rescue nil
      end
    end
    @identity
  end

end
