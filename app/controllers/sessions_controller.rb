class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # for debug, dump to file.
    dump_auth_hash unless Rails.env.production?

    if identity = Identity.from_omniauth(auth_hash)
      session[:identity_id] = identity.id
      session[:user_id] = identity.user_id
      flash[:message] = "You are now logged in."

      # Redirect to return_to, which should be URL (path part only) that the customer came from.
      return_to = session.delete(:return_to)
      redirect_to return_to.blank? ? root_url : return_to
    else
      raise "login failed"
    end
  end

  def destroy
    session[:identity_id] = nil
    session[:user_id] = nil
    session.destroy
    redirect_to root_url
  end

protected
  def auth_hash
    request.env['omniauth.auth']
  end

  def dump_auth_hash
    File.open("/tmp/omniauth-#{Time.now.to_i}.log", "ab") do |fh|
      fh.puts auth_hash.to_yaml
    end
  rescue Exception => ex
    # IGNORED.
  end

end
