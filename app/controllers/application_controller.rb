class ApplicationController < ActionController::Base
  include KnowsCurrentUser

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :breadcrumb_init, :current_user, :page_meta

  attr_accessor :breadcrumbs

  #unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActionController::UnknownController,
                ActionController::MethodNotAllowed do |exception|
      render404
    end
  #end


  def render404
    respond_to do |fmt|
      fmt.html {
        render :action=>'error404', :status=>404
      }
      fmt.all { render :action=>'error404', :status=>404, :formats=>[:html]}
    end
  end

  # used for supplying filenames for KML/CSV
  def set_filename(filename)
    response.headers['Content-Disposition'] = 'attachment; filename="' + filename
  end

protected

  def breadcrumb_init
    @breadcrumbs = BreadcrumbTrail.new(request)
  end

  def page_title=(t)
    @page_title=t
    @breadcrumbs.here.title=t
  end


  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


  def enable_profiling
    if defined?(Rack::MiniProfiler)
      Rack::MiniProfiler.authorize_request
    end
  rescue Exception => ex
  end

  def page_meta
    unless @page_meta
      @page_meta = PageMeta.new(request)
    end
  end

  # Allow user to override layout via layout=[something] param.
  def render_with_selected_layout(*args)
    if layout = allowed_layout
      args.push({}) unless args.last.is_a?(Hash)
      args.last[:layout] = layout
    end
    render *args
  end

  def allowed_layout
    layouts = [ 'application', 'modal']

    l = params[:layout] or return false
    return layouts.index(l) ? l : false
  end

end
