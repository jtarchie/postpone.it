class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth_action("Facebook")
  end

  def twitter
    omniauth_action("Twitter")
  end

  def vimeo
    omniauth_action("Vimeo")
  end

  def you_tube
    omniauth_action("YouTube")
  end

  private
  def omniauth_action(provider)
    omniauth = request.env['omniauth.auth']
    if current_user
      authorization = current_user.authorizations.where(:provider => omniauth['provider'], :uid => omniauth['uid'])
      authorization = authorization.first.present? ? authorization.first : authorization.create
      authorization.update_attributes(
        :token => omniauth['credentials']['token'],
        :secret => omniauth['credentials']['secret']
      )
      redirect_to accounts_path, :notice => "Successfully authorized with #{provider}"
    end
  end
end