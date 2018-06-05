class Instructors::InstructorsController < ApplicationController

  def show
    @instructor = Instructor.friendly.find(params[:id])
    @courses = @instructor.courses.page params[:page]
    @popular_courses = @instructor.courses.left_joins(:purchases).group(:id).order('COUNT(purchases.id) DESC').limit(4)
    @posts = @instructor.posts
    if instructor_signed_in? && current_instructor == @instructor
      @profile = current_instructor.profile
      @course = Course.new
      @post = Post.new
    end
    unless @instructor.plan_id == @instructor.id.to_s
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      @plan = Stripe::Plan.retrieve(@instructor.plan_id, stripe_account: @instructor.merchant.stripe_id)
      @amount = BigDecimal(@plan.amount) / 100
    end
    if student_signed_in?
      @subscription = Subscription.new
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      @customer = Stripe::Customer.retrieve(current_student.customer_id)
    end
  end

end