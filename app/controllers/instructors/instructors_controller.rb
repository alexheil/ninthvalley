class Instructors::InstructorsController < ApplicationController

  def show
    @instructor = Instructor.friendly.find(params[:id])
    if instructor_signed_in? && current_instructor == @instructor
      @profile = current_instructor.profile
    end
  end

end