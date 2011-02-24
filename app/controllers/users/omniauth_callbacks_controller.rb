class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth = request.env['omniauth.auth']
    if current_user
      authorization = current_user.authorizations.where(:provider => omniauth['provider'], :uid => omniauth['uid']).create
      authorization.update_attributes :token => omniauth['credentials']['token']
      redirect_to accounts_path, :notice => "Successfully authorized with Facebook"
    end
  end
end