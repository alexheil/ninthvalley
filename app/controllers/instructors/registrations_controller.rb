# frozen_string_literal: true

class Instructors::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    @instructor.create_profile(profile_params)
  
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    product = Stripe::Product.create(
      id: @instructor.username + "_" + @instructor.id.to_s,
      name: @instructor.username + "_" + @instructor.id.to_s,
      type: 'service',
      statement_descriptor: "NINVAL | " + @instructor.username[0...13].upcase,
    )

    @instructor.update_attributes(
      product_id: product.id,
      plan_id: @instructor.id
    )
  end

  # GET /resource/edit
  def edit
    super
    @instructor = current_instructor

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    unless @instructor.plan_id == @instructor.id.to_s
      @plan = Stripe::Plan.retrieve(@instructor.plan_id)
    end
  end

  # PUT /resource
  def update
    super
    @instructor = current_instructor

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    product = Stripe::Product.retrieve(@instructor.product_id)

    if @instructor.plan_id == @instructor.id.to_s
      plan = Stripe::Plan.create(
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product: product.id,
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      )

      @instructor.update_attributes(
        plan_id: plan.id
      )
    else
      plan = Stripe::Plan.retrieve(@instructor.plan_id)
      plan.delete

      plan = Stripe::Plan.create(
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product: product.id,
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      )

      @instructor.update_attributes(
        plan_id: plan.id
      )
    end
  end

  def edit_plan
    @instructor = current_instructor

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    unless @instructor.plan_id == @instructor.id.to_s
      @plan = Stripe::Plan.retrieve(@instructor.plan_id)
    end
  end

  def update_plan
    @instructor = current_instructor

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    product = Stripe::Product.retrieve(@instructor.product_id)

    if @instructor.plan_id == @instructor.id.to_s
      plan = Stripe::Plan.create(
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product: product.id,
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      )

      @instructor.update_attributes(
        plan_id: plan.id
      )
    else
      plan = Stripe::Plan.retrieve(@instructor.plan_id)
      plan.delete

      plan = Stripe::Plan.create(
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product: product.id,
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      )

      @instructor.update_attributes(
        plan_id: plan.id
      )
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
