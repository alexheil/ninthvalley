class Instructors::InstructorsController < ApplicationController

  def show
    @instructor = Instructor.friendly.find(params[:id])
  end

end