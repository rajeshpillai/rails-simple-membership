class UsersController < ApplicationController
  before_action :authorize, only: [:index]
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params)
    p @user
    if @user.save
      session[:user_id] = @user.id  # automatic login
      redirect_to root_url, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

  

  private
  def user_params()
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
