class Instructors::SubscriptionsController < ApplicationController

  before_action :authenticate_student!
  before_action :check_default_source, only: :create

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @subscription = @instructor.subscriptions.build(subscription_params)
    @subscription.student_id = @student.id
    @subscription.instructor_id = @instructor.id

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    customer = Stripe::Customer.retrieve(@student.customer_id)

    token = Stripe::Token.create({
      customer: customer.id,
      card: customer.default_source,
    }, stripe_account: @instructor.merchant.stripe_id)

    subscription_customer = Stripe::Customer.create({
      email: @student.email
    }, stripe_account: @instructor.merchant.stripe_id)

    plan = Stripe::Plan.retrieve(@instructor.plan_id, stripe_account: @instructor.merchant.stripe_id)

    subscription = Stripe::Subscription.create({
      customer: subscription_customer.id,
      source: token,
      application_fee_percent: 10,
      items: [
        {plan: plan.id}
      ],
    }, stripe_account: @instructor.merchant.stripe_id)

    subscription.save

    if subscription.save
      @subscription.update_attributes(
        stripe_subscription_id: subscription.id,
      )
      redirect_to instructor_path(@instructor)
      flash.now[:notice] = "You subscribed to #{@instructor.username}!"
    else 
      redirect_to root_url
    end
  end

  def destroy
    current_fan.unfollow_artist(Artist.friendly.find(params[:artist_id]))
    @artist = Artist.friendly.find(params[:artist_id])
    flash.now[:notice] = "you unfollowed #{@artist.artist_name}!"
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js { render :action => "follow_button" }
    end
  end

  private

    def subscription_params
      params.permit(:stripe_subscription_id)
    end

    def check_default_source
      @instructor = Instructor.friendly.find(params[:instructor_id])
      @student = current_student
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      customer = Stripe::Customer.retrieve(@student.customer_id)
      if customer.default_source.blank?
        url = instructor_url(@instructor)
        redirect_to student_edit_source_path(@student, :url => Base64.encode64(url))
      end
    end

end