class Instructors::TracksController < ApplicationController

  before_action :authenticate_instructor!, except: :show
  before_action :correct_instructor, only: :create
  before_action :correct_course_instructor, only: [:update, :destroy]
  before_action :set_instructor, except: :show

  def show
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:id])
  end

  def create
    @course = Course.friendly.find(params[:course_id])
    @track = @course.tracks.build(track_params)
    @track.instructor_id = @instructor.id
    if @track.save
      flash[:notice] = "You just created " + @track.title + "!"
      redirect_to instructor_course_track_path(@instructor, @course, @track)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def update
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:id])
    if @track.update_attributes(track_params)
      flash[:notice] = "You just updated " + @track.title + "!"
      redirect_to instructor_course_track_path(@instructor, @course, @track)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def destroy
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:id]).destroy
  end

  private

    def track_params
      params.require(:track).permit(:title)
    end

    def set_instructor
      @instructor = current_instructor
    end

    def correct_instructor
      @instructor = User.friendly.find(params[:instructor_id])
      if current_instructor != @instructor
        redirect_to instructor_path(@instructor)
        flash[:alert] = "This is not your profile."
      end
    end

    def correct_course_instructor
      @course = Course.friendly.find(params[:id])
      redirect_to instructor_path(@course.instructor_id) if @course.instructor_id != current_instructor.id
    end

end