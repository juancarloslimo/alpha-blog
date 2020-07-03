class UsersController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alphalfa Blog #{@user.username.upcase}, you have succesfully signed up"
      redirect_to articles_path
    else
      render 'new' 
    end
  end

  def edit
    # When "Update account" button is submitted, it calls update methods sending just parameters and not @user, because of that in update method
    # we have to find one more time which user will be updated. In other words, form sends data as params.
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was updated successfully"
      redirect_to user_path(@user) # I just could use @user instead of user_path(@user). Ruby is smart enough to know what I want to do.
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles succesfully deleted"
    redirect_to users_path
  end

  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_article
    @user = User.find(params[:id])
  end

  def require_same_user
    if @user != current_user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile"
      redirect_to @user
    end
  end

end
