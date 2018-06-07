class Instructors::ReviewsController < ApplicationController

  before_action :authenticate_student!
  before_action :correct_student_review, only: [:update, :destroy]

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @review = @course.reviews.build(review_params)
    @review.student_id = @student.id
    @review.instructor_id = @instructor.id
    if @review.save
      flash.now[:notice] = "You posted a review on #{@course.title}."
      create_notification(@review)
      send_email
      redirect_to instructor_course_path(@instructor, @course)
    else
      redirect_to (:back)
      flash[:alert] = "You failed."
    end
  end

  def update
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:notice] = "You just updated your review on #{@course.title}!"
      redirect_to instructor_course_path(@instructor, @course)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def destroy
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @review = Review.find(params[:id]).destroy
    redirect_to instructor_course_path(@instructor, @course)
    flash[:notice] = "You have succesfully deleted your review!"
  end

  private

    def review_params
      params.require(:review).permit(:rating, :content)
    end

    def correct_student_review
      @instructor = Instructor.friendly.find(params[:instructor_id])
      @course = Course.friendly.find(params[:course_id])
      @review = Review.find(params[:id])
      redirect_to instructor_path(@instructor) if @review.student_id != current_student.id
    end

    def create_notification(review)
      Notification.create(instructor_id: review.course.instructor_id,
        student_id: current_student.id,
        review_id: review.id,
        notice_type: 'review')
    end

    def send_email
      return if instructor_signed_in? && @instructor.id == current_instructor.id
      InstructorMailer.review_email(@instructor, @review).deliver_now unless @instructor.review_email == false
    end

end