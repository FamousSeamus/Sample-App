class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name 
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user), :flash => { :success => "Welcome to the Sample App"}
      sign_in @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def edit
  
    @title = "Edit user"
  end
  
  def update
    
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated"}
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
   @user.destroy
   redirect_to users_path, :flash => { :success => "User deleted"}
  end
  
  private 
  
    def admin_user
      @user = User.find(params[:id])
     redirect_to(root_path) unless (!current_user?(@user) && current_user.admin?)
    end
    
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
