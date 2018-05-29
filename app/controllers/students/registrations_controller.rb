# frozen_string_literal: true

class Students::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    @profile = @student.create_profile(profile_params)
  
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    customer = Stripe::Customer.create(
      email: @student.email
    )

    @student.update_attributes(
      customer_id: customer.id
    )
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  def edit_source
    if student_signed_in?
      @student = current_student

      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

      @customer = Stripe::Customer.retrieve(@student.customer_id)
    else
      redirect_to root_url
    end
  end

  def update_source
    @student = current_student

    redirection = nil
    if params[:url].present?
      redirection = Base64.decode64(params[:url].to_s)
    end

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    customer = Stripe::Customer.retrieve(@student.customer_id)

    token = params[:stripeToken]

    source = customer.sources.create({source: token})
    customer.default_source = source.id
    customer.save

    if customer.save
      if redirection.present?
        path = redirection
      else
        path = student_path(@student)
      end
      redirect_to path
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

    def profile_params
      params.permit(:biography, :first_name, :last_name, :website, :city, :state, :country, :twitter_handle, :twitter_url, :youtube_handle, :youtube_url, :image, :remove_image)
    end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
