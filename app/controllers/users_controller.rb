class UsersController < ApplicationController

  before_action :set_article, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
      flash[:notice] = "Article was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_article
    @user = User.find(params[:id])
  end

end
