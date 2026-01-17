# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_path, alert: "管理者権限が必要です。"
    end
  end
end