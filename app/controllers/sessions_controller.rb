class SessionsController < ApplicationController
  def new
  end

  def create
    if using_open_id?
      open_id_authentication(params[:openid_url])
    else
      password_authentication(params[:login], params[:password])
    end
  end
   
  def destroy
    session[:user_id] = nil
    cookies.delete :auth_token
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

private

  def find_or_initialize_user(identity_url)
    if logged_in?
      current_user.identity_url = identity_url
      current_user.save
      current_user
    else
      User.find_or_initialize_by_identity_url(identity_url)
    end
  end

  def open_id_authentication(openid_url)
    authenticate_with_open_id(openid_url, :required => [:nickname, :email]) do |result, identity_url, registration|
      if result.successful?
        user = find_or_initialize_user(identity_url)
        if user.new_record?
          user.username = registration['nickname']
          user.email = registration['email']
          user.save(false)
        end
        successful_login user
      else
        failed_login result.message
      end
    end
  end

  def password_authentication(login, password)
    user = User.authenticate(login, password)
    if user
      successful_login user
    else
      failed_login
    end
  end

  def failed_login(message = "Authentication failed.")
    flash.now[:error] = message
    render :action => 'new'
  end

  def successful_login(user)
    if params[:remember_me] == "1"
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    end
    session[:user_id] = user.id
    if !(user.username || user.email)
      flash[:notice] = "Logged in successfully... but we need a little more info!"
      redirect_to edit_user_path(user)
    else
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(root_url)
    end
  end
end