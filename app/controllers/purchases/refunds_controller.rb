class Purchases::RefundsController < ApplicationController

  before_action :authenticate_student!

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @purchase = Purchase.find(params[:purchase_id])

    if @purchase.stripe_charge_id.starts_with?("ch")
      if (@course.refund_policy == "three" && @purchase.created_at > 3.days.ago) || (@course.refund_policy == "seven" && @purchase.created_at > 7.days.ago)

        Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
        charge = Stripe::Charge.retrieve(@purchase.stripe_charge_id)

        refund = Stripe::Refund.create(
          charge: charge.id,
          refund_application_fee: true,
          reverse_transfer: true
        )

        if refund.save
          @purchase.update_attributes(
            stripe_charge_id: refund.id,
          )
          send_email
          send_student_email
          redirect_to instructor_path(@instructor)
          flash[:notice] = "You have successfully refunded #{@course.title}."
        else 
          redirect_to root_url
          flash[:alert] = "You have failed to refund this course."
        end

      else
        redirect_to instructor_course_path(@instructor, @course)
        flash[:notice] = "You cannot refund this course."
      end
    else
      redirect_to instructor_course_path(@instructor, @course)
      flash[:notice] = "You have already refunded this course."
    end
  end

  private

    def send_email
      InstructorMailer.refund_email(@instructor, @purchase).deliver_now unless @instructor.refund_email == false
    end

    def send_student_email
      StudentMailer.refund_email(@student, @instructor, @purchase).deliver_now
    end

end