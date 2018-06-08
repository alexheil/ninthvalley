class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :current_password, :remember_me, :customer_id, :plan_id, :product_id, :purchase_email, :refund_email, :subscription_email, :review_email, :comment_email, :message_email, :course_email, :post_email]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
    
end
