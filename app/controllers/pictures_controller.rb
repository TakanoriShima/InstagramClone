class PicturesController < ApplicationController
  before_action :set_picture, only: %i[show edit update destroy]
  before_action :is_login, only: %i[new edit destroy]

  def index
    @pictures = picture.all
  end

  def new
    @picture = if params[:back]
                 picture.new(picture_params)
               else
                 picture.new
               end
  end

  def confirm
    @picture = picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  def create
    @picture = picture.new(picture_params)
    @picture.user_id = current_user.id

    if params.key?(:cache)
      @picture.image.retrieve_from_cache! params[:cache][:image]
    end

    if @picture.save
      pictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿しました >>> 投稿完了のメールを送信しました'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '投稿を編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: '投稿を削除しました'
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  private

  def picture_params
    params.require(:picture).permit(:comment, :image, :image_cache)
  end

  def set_picture
    @picture = picture.find(params[:id])
  end
end
