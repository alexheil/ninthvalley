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
      create_notification(@subscription)
      send_email
      redirect_to instructor_path(@instructor)
      flash[:notice] = "You subscribed to #{@instructor.profile.first_name.presence || @instructor.username}!"
    else 
      redirect_to root_url
    end
  end

  def destroy
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @subscription = Subscription.find(current_student.subscription_id(@instructor))

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    subscription = Stripe::Subscription.retrieve(@subscription.stripe_subscription_id, stripe_account: @instructor.merchant.stripe_id)

    if subscription.delete
      current_student.unsubscribe(@instructor)
      redirect_to instructor_path(@instructor)
      flash[:notice] = "You unsubscribed from #{@instructor.profile.first_name.presence || @instructor.username}."
    else
      redirect_to instructor_path(@instructor)
      flash[:alert] = "You did not unsubscribe from #{@instructor.profile.first_name.presence || @instructor.username}."
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

    def create_notification(subscription)
      Notification.create(instructor_id: subscription.instructor_id,
        student_id: current_student.id,
        subscription_id: subscription.id,
        notice_type: 'subscription')
    end

    def send_email
      InstructorMailer.subscription_email(@instructor, @subscription).deliver_now unless @instructor.subscription_email == false
    end

end