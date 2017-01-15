class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def authenticate_user! # ALREADY EXISTS with DEVISe
  #   redirect_to '/login' unless current_user
  # end

  def authenticate_admin!
    authenticate_user!

    if !current_user.admin 
      flash[:danger] = "You are not permitted to access this area."
      # redirect_to request.referrer
      #   redirect_to :back
      # rescue ActionController::RedirectBackError
      #   redirect_to root_path
      redirect_to '/'
    end
  end
end
