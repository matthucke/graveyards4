#
# Included into ApplicationController, this has all functions relevant to
# knowing about the current user and what s/he can do.
#
module KnowsCurrentUser
  extend ActiveSupport::Concern

  # Get current user or redirect back to main page.
  # Suitable for use as before_action.
  def current_user!(msg=nil)
    (current_user.tap do |u|
      unless u
        flash[:error] = msg || "You must be logged in to use this feature."
        redirect_to '/'
      end
    end) || false
  end

  def current_user
    @current_user ||= load_current_user
  end

  def current_identity
    unless @current_identity
      if iid = session[:identity_id]
        @current_identity = Identity.find(iid) rescue nil
      end
    end
    @current_identity
  end

  def load_current_user
    ident = current_identity or return nil

    ident.user.tap do |u|
      return nil unless u
      enable_profiling if u.admin?
    end
  end

  # Require that the user owns the object in question
  def require_owner_of!(object, user: nil, message: nil)
    user ||= current_user
    if object.respond_to?(:user_id)
      return true if object.user_id == user.id
    end
    if object.respond_to?(:user)
      return true if object.user == user
    end

    return true if user.admin?

    flash[:error] = message || "Sorry, you are not the owner of this #{object.class.name}"
    redirect_to '/'
    false
  end

  def require_admin!
    current_user.tap do |u|
      unless u && u.admin?
        flash[:error] = "This action is restricted to admin users only."
        redirect_to root_path
      end
    end
  end


end