class Purchases::PurchasesController < ApplicationController

  before_action :authenticate_student!

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @purchase = @course.purchases.build(purchase_params)
    @purchase.student_id = @student.id
    @purchase.instructor_id = @instructor.id
    
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    customer = Stripe::Customer.retrieve(current_student.customer_id)

    if customer.default_source.present? && params[:purchase][:use_your_card] == "1"

      amount = ((@course.price) * 100).to_i
      application_fee = (((@course.price * 0.129) + 0.30) * 100).round

      begin
        charge = Stripe::Charge.create(
          amount: amount,
          application_fee: application_fee,
          currency: @instructor.merchant.currency,
          destination: @instructor.merchant.stripe_id,
          customer: customer.id,
          description: "#{@course.title} | Ninth Valley",
          statement_descriptor: "NINVAL | " + @course.title[0...13].upcase.gsub(/[^a-z0-9\s]/i, '')
        )
      rescue Stripe::CardError => e
        # The card has been declined
        render 'checkout'
        flash.now[:alert] = "Your card has been declined."
      end

    else

      token = params[:stripeToken]
      amount = ((@course.price) * 100).to_i
      application_fee = (((@course.price * 0.129) + 0.30) * 100).round

      begin
        charge = Stripe::Charge.create(
          amount: amount,
          application_fee: application_fee,
          currency: @instructor.merchant.currency,
          destination: @instructor.merchant.stripe_id,
          source: token,
          description: "#{@course.title} | Ninth Valley",
          statement_descriptor: "NINVAL | " + @course.title[0...13].upcase.gsub(/[^a-z0-9\s]/i, '')
        )
      rescue Stripe::CardError => e
        # The card has been declined
        render 'checkout'
        flash.now[:alert] = "You have failed."
      end

    end

    if charge.save
      @purchase.update_attributes(
        stripe_charge_id: charge.id
      )
      # send_purchase_email
      redirect_to instructor_course_path(@instructor, @course)
      flash[:notice] = "You have successfully purchased #{@course.title}!"
    else
      render 'checkout'
      flash.now[:alert] = "Your card has been declined."
    end

  end

  def checkout
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @purchase = Purchase.friendly.find(params[:id])
    @student = current_student
  end

  def charge
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @purchase = Purchase.friendly.find(params[:id])
    @student = current_student

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    customer = Stripe::Customer.retrieve(@student.customer_id)

    token = params[:stripeToken]
    amount = ((@course.price) * 100).to_i
    application_fee = (((@course.price * 0.129) + 0.30) * 100).round

    begin
      charge = Stripe::Charge.create(
        amount: amount,
        application_fee: application_fee,
        currency: @instructor.merchant.currency,
        destination: @instructor.merchant.stripe_id,
        source: token,
        description: "#{@course.title} | Ninth Valley",
        statement_descriptor: "NINVAL | " + @course.title[0...13].upcase.gsub(/[^a-z0-9\s]/i, '')
      )
    rescue Stripe::CardError => e
      # The card has been declined
      render 'checkout'
      flash.now[:alert] = "You have failed."
    end

    if charge.save
      @purchase.update_attributes(
        stripe_charge_id: charge.id
      )
      # send_purchase_email
      redirect_to instructor_course_path(@instructor, @course)
      flash[:notice] = "You have successfully purchased #{@course.title}!"
    else
      render 'checkout'
      flash.now[:alert] = "Your card has been declined."
    end
  end

  private 

    def purchase_params
      params.permit(:stripe_charge_id, :use_your_card)
    end

end