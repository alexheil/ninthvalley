class Instructors::CommentsController < ApplicationController

  before_action :authenticate_commenter

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    if instructor_signed_in?
      @comment.instructor_id = current_instructor.id
    elsif student_signed_in?
      @comment.student_id = current_student.id
    end
    if @comment.save
      flash.now[:notice] = "You posted a comment on #{@video.title}."
      create_notification(@comment)
      send_email
      redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
    else
      redirect_to (:back)
      flash[:alert] = "You failed."
    end
  end

  def update
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "You just updated your comment on #{@video.title}!"
      redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def destroy
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = Comment.find(params[:id]).destroy
    redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def authenticate_commenter
      redirect_to sign_in_path unless instructor_signed_in? || student_signed_in?
    end

    def correct_user
      @instructor = Instructor.friendly.find(params[:instructor_id])
      @course = Course.friendly.find(params[:course_id])
      @track = Track.friendly.find(params[:track_id])
      @video = Video.friendly.find(params[:video_id])
      @comment = Comment.find(params[:id])
      if instructor_signed_in?
        if current_instructor.id != @comment.instructor_id
          redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
          flash[:alert] = "This is not your comment."
        end
      elsif student_signed_in?
        if current_student.id != @comment.student_id
          redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
          flash[:alert] = "This is not your comment."
        end
      end
    end

    def create_notification(comment)
      Notification.create(instructor_id: comment.video.instructor_id,
        student_id: current_student.id,
        comment_id: comment.id,
        notice_type: 'comment')
    end

    def send_email
      return if instructor_signed_in? && @instructor.id == current_instructor.id
      InstructorMailer.comment_email(@instructor, @comment).deliver_now unless @instructor.comment_email == false
    end

end