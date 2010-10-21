class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # GET /posts/1/edit
  def edit
    @user = User.find(params[:id])
    if params[:open]
      render :action => 'add_open_id'
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      @user.avatar = params[:user][:avatar] 
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
