class SessionsController < ApplicationController
  def create
    begin
      user(auth: request.env['omniauth.auth'])

      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
    rescue
      flash[:warning] = 'There was an error while trying to authenticate you...'
    end
    redirect_to dashboard_index_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  private

  def user(auth:)
    provider = auth['provider']
    uid = auth['uid']

    @user = User.find_by_provider_and_uid(provider: provider, uid: uid) || User.create_with_omniauth(auth_hash: auth)
  end
end
