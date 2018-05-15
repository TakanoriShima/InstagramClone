class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: @picture.user.email, subject: '【InstagramClone】新しく投稿しました！'
  end
end
