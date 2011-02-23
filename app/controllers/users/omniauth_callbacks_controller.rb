class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(method, *args)
    raise "Unknown Provider Method: #{method}" unless method.to_s.downcase =~ /facebook/
    omniauth = request.env['omniauth.auth']
    if current_user
      current_user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to accounts_path, :notice => "Successfully authorized with #{method.to_s.humanize}"
    end
  end
end