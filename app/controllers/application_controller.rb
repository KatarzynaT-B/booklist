class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Nie masz uprawnień"
      redirect_to root_path
    end
  end

  def info_for_paper_trail
    { ip: request.remote_ip }
  end



end
