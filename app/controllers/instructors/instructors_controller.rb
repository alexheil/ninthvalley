class Instructors::InstructorsController < ApplicationController

  def show
    @instructor = Instructor.friendly.find(params[:id])
    @courses = @instructor.courses.page params[:page]
    @popular_courses = @instructor.courses.reorder("created_at desc").limit(5)
    if instructor_signed_in? && current_instructor == @instructor
      @profile = current_instructor.profile
      @course = Course.new
    end
  end

end