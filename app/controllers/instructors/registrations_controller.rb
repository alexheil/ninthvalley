# frozen_string_literal: true

class Instructors::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_instructor!, only: [:edit_plan, :update_plan]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    @instructor.create_profile(profile_params)

    @instructor.update_attributes(
      plan_id: @instructor.id,
      product_id: @instructor.id
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

  def edit_plan
    if instructor_signed_in? && current_instructor.merchant.present?
      @instructor = current_instructor

      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

      unless @instructor.plan_id == @instructor.id.to_s
        account = Stripe::Account.retrieve(@instructor.merchant.stripe_id)
        @plan = Stripe::Plan.retrieve(@instructor.plan_id, stripe_account: @instructor.merchant.stripe_id)
        @amount = BigDecimal(@plan.amount) / 100
      end
    elsif instructor_signed_in? && current_instructor.merchant.nil?
      redirect_to new_instructor_merchant_path(current_instructor)
      flash[:alert] = "You need to set up a merchant account first."
    else
      redirect_to root_url
    end
  end

  def update_plan
    @instructor = current_instructor

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    if @instructor.plan_id == @instructor.id.to_s
      plan = Stripe::Plan.create({
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product:
        {
          id: @instructor.username + "_" + @instructor.id.to_s,
          name: @instructor.username + "_" + @instructor.id.to_s,
          statement_descriptor: "NINVAL | " + @instructor.username[0...13].upcase
        },
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      }, stripe_account: @instructor.merchant.stripe_id)
    else
      plan = Stripe::Plan.retrieve(@instructor.plan_id, stripe_account: @instructor.merchant.stripe_id)
      plan.delete
      product = Stripe::Product.retrieve(@instructor.product_id, stripe_account: @instructor.merchant.stripe_id)
      product.delete

      plan = Stripe::Plan.create({
        amount: (params[:instructor][:plan_amount].to_i * 100).to_s,
        interval: "month",
        product:
        {
          id: @instructor.username + "_" + @instructor.id.to_s,
          name: @instructor.username + "_" + @instructor.id.to_s,
          statement_descriptor: "NINVAL | " + @instructor.username[0...13].upcase
        },
        currency: params[:instructor][:currency],
        id: @instructor.username + "_" + @instructor.id.to_s
      }, stripe_account: @instructor.merchant.stripe_id)
    end

    if plan.save
      @instructor.update_attributes(
        plan_id: plan.id,
        product_id: plan.product
      )
      redirect_to instructor_path(@instructor)
      flash[:notice] = "You have successfully created a subscription!"
    else
      redirect_to instructor_path(@instructor)
      flash[:alert] = "You failed to create a subscription."
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
