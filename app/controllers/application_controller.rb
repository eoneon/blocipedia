class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = "you're not allowed to do that"
    redirect_to :back
  end

  private

  def upgrade_account
    user = current_user
    user.role = :premium

    if user.save
      flash[:notice] = "Your account has been successfully upgraded to premium! #{@charge.id}"
    end
  end

  def downgrade_account
    user = current_user
    user.role = :standard

    if user.save
      flash[:notice] = "Your account has been successfully downgradeed to standard!"
    end
  end

end
