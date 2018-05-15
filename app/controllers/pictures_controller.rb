class PicturesController < ApplicationController
  before_action :set_picture, only: %i[show edit update destroy]
  before_action :login?, only: %i[new edit destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = if params[:back]
                 Picture.new(picture_params)
               else
                 Picture.new
               end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    if params.key?(:cache)
      @picture.image.retrieve_from_cache! params[:cache][:image]
    end

    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿しました >>> 投稿完了のメールを送信しました'
    else
      render 'new'
    end
  end

  def edit
  end

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
  end

  private

  def picture_params
    params.require(:picture).permit(:comment, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
