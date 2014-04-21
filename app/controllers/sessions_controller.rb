class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      File.open("/tmp/omni.log", "ab") do |fh|
        fh.puts auth_hash.to_yaml
      end
    rescue Exception => ex
      # IGNORED.
    end

    if identity = Identity.from_omniauth(auth_hash)
      session[:identity_id] = identity.id
      session[:user_id] = identity.user_id
      flash[:message] = "You are now logged in."
      redirect_to root_url
    else
      raise "login failed"
    end
  end

  def destroy
    session[:user_id] = nil
    session.destroy
    redirect_to root_url
  end

protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
