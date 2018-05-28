class Instructors::InstructorsController < ApplicationController

  def show
    @instructor = Instructor.friendly.find(params[:id])
    @courses = @instructor.courses.page params[:page]
    @popular_courses = @instructor.courses.reorder("created_at desc").limit(4)
    @posts = @instructor.posts
    if instructor_signed_in? && current_instructor == @instructor
      @profile = current_instructor.profile
      @course = Course.new
      @post = Post.new
    end
    unless @instructor.plan_id == @instructor.id.to_s
      @plan = Stripe::Plan.retrieve(@instructor.plan_id)
      @amount = BigDecimal(@plan.amount) / 100
    end
  end

end