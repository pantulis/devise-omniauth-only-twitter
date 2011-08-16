class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def twitter
    @user = User.find_for_twitter_oauth(env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication,
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Twitter', reason: 'User not found'
      redirect_to new_user_session_path
    end
  end
  
  def passthru
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
end