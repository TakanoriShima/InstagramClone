module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def login?
    redirect_to sessions_new_path, notice: 'ログインが必要な機能です' unless logged_in?
  end
end
