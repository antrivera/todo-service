class UsersController < ApplicationController
  before_action :require_current_user!, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    render 'todo_items/index', locals: { filter: true }
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
