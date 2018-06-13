class Messages::MessagesController < ApplicationController

  before_action :authenticate_student!, only: :create

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @message = @instructor.messages.build(message_params)
    @message.student_id = @student.id
    @message.instructor_id = @instructor.id
    if @message.save
      redirect_to instructor_path(@instructor)
      flash[:notice] = "Your message has successfuly been sent."
      send_email
    else
      redirect_to instructor_path(@instructor)
      flash[:notice] = "Your message failed to send."
    end
  end

  def destroy
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @message = Message.find(params[:id]).destroy
    if student_signed_in?
      redirect_to student_path(@student)
    else
      redirect_to instructor_path(@instructor)
    end
    flash[:notice] = "You have successfuly deleted a message."
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end

    def send_email
      InstructorMailer.message_email(@instructor, @message).deliver_now unless @instructor.message_email == false
    end

end