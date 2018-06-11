class Instructors::CoursesController < ApplicationController

  before_action :authenticate_instructor!, except: [:search, :show]
  before_action :correct_instructor, only: [:new, :create]
  before_action :correct_course_instructor, only: [:edit, :update, :destroy]
  before_action :set_instructor, except: [:search, :show]
  before_action :deletable, only: :destroy

  def search
    @courses = Course.search(params[:search]).order("created_at DESC").page params[:page]
  end

  def show
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:id])
    if instructor_signed_in? && current_instructor == @instructor
      @track = Track.new
      @video = Video.new
    end
    if student_signed_in?
      @review = Review.new
      @purchase = Purchase.new
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      @customer = Stripe::Customer.retrieve(current_student.customer_id)
    end
    if student_signed_in? && current_student.purchased?(@course)
      @purchased_course = Purchase.find(current_student.purchase_id(@course))
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = @instructor.courses.build(course_params)
    if @course.save
      flash[:notice] = "You just created " + @course.title + "!"
      redirect_to instructor_course_path(@instructor, @course)
      send_student_email
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:id])
  end

  def update
    @course = Course.friendly.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:notice] = "You just updated " + @course.title + "!"
      redirect_to instructor_course_path(@instructor, @course)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'edit'
    end
  end

  def destroy
    @course = Course.friendly.find(params[:id]).destroy
    redirect_to instructor_path(@instructor)
    flash[:notice] = "You deleted your course."
  end

  private

    def course_params
      params.require(:course).permit(:subcategory_id, :category_id, :title, :tagline, :language, :requirements, :description, :highlights, :target, :paid, :price, :refund_policy, :currency, :image, :remove_image)
    end

    def set_instructor
      @instructor = current_instructor
    end

    def correct_instructor
      @instructor = Instructor.friendly.find(params[:instructor_id])
      if current_instructor != @instructor
        redirect_to instructor_path(@instructor)
        flash[:alert] = "This is not your profile."
      end
    end

    def correct_course_instructor
      @course = Course.friendly.find(params[:id])
      redirect_to instructor_path(@course.instructor_id) if @course.instructor_id != current_instructor.id
    end

    def deletable
      @instructor = Instructor.friendly.find(params[:instructor_id])
      @course = Course.friendly.find(params[:id])
      if @course.purchases.any?
        redirect_to instructor_course_path(@instructor, @course)
        flash[:alert] = "This course has been purchased. You cannot delete it at this time."
      end
    end

    def send_student_email
      @instructor.subscriptions.find_each do |subscription|
        StudentMailer.course_email(@subscription, subscription.student, @instructor, @purchase).deliver_now unless subscription.student.course_email == false
      end
    end

end