class Students::StudentsController < ApplicationController

  def show
    @student = Student.friendly.find(params[:id])
    if student_signed_in? && current_student == @student
      @profile = current_student.profile
    end
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    
    @customer = Stripe::Customer.retrieve(@student.customer_id)
  end

end