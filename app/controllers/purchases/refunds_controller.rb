class Purchases::RefundsController < ApplicationController

  before_action :authenticate_student!

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @purchase = Purchase.find(params[:purchase_id])

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    charge = Stripe::Charge.retrieve(@purchase.stripe_charge_id)

    refund = Stripe::Refund.create(
      charge: charge.id,
      refund_application_fee: true
    )

    if refund.save
      @purchase.update_attributes(
        stripe_charge_id: refund.id,
      )
      redirect_to instructor_path(@instructor)
      flash[:notice] = "You have successfully refunded #{@course.title}."
    else 
      redirect_to root_url
    end
  end

  private

    def refundable

    end

end