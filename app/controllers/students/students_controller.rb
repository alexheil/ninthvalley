class Students::StudentsController < ApplicationController

  def show
    @student = Student.friendly.find(params[:id])
    if student_signed_in? && current_student == @student
      @profile = current_student.profile
    end
  end

end