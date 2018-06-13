class Messages::RepliesController < ApplicationController

  #before_action :authenticate_student!, only: :create

  def create
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @message = Message.find(params[:message_id])
    @student = @message.student
    @reply = @message.replies.build(reply_params)
    if student_signed_in?
      @reply.student_id = @student.id
    else
      @reply.instructor_id = @instructor.id
    end
    if @reply.save
      redirect_to instructor_path(@instructor)
      flash[:notice] = "Your reply has successfuly been sent."
      send_instructor_email
      send_student_email
    else
      redirect_to instructor_path(@instructor)
      flash[:notice] = "Your reply failed to send."
    end
  end

  def destroy
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @message = Message.find(params[:message_id])
    @student = @message.student
    @reply = Reply.find(params[:id]).destroy
    if student_signed_in?
      redirect_to student_path(@student)
    else
      redirect_to instructor_path(@instructor)
    end
    flash[:notice] = "You have successfuly deleted a reply."
  end

  private

    def reply_params
      params.require(:reply).permit(:content)
    end

    def send_instructor_email
      return if instructor_signed_in? && @instructor.id == current_instructor.id
      InstructorMailer.reply_email(@instructor, @reply).deliver_now unless @instructor.message_email == false
    end

    def send_student_email
      return if student_signed_in? && @student.id == current_student.id
      StudentMailer.message_email(@student, @instructor, @reply).deliver_now unless @student.message_email == false
    end

end