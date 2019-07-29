class UsersController < ApplicationController
  def new
    if logged_in?
      @pictures = Picture.all
      render 'pictures/index'
    else
      @user = User.new
      render 'top'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'ユーザ登録が完了しました'
    else
      render 'top_signup'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation, :image, :image_cache)
  end
end
