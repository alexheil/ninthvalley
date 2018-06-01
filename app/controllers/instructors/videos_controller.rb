class Instructors::VideosController < ApplicationController

  before_action :authenticate_instructor!, except: :show
  before_action :correct_instructor, only: :create
  before_action :correct_video_instructor, only: [:update, :destroy]
  before_action :set_instructor, except: :show

  def show
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:id])
    if instructor_signed_in? or student_signed_in?
      @comment = Comment.new
    end
  end

  def create
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = @track.videos.build(video_params)
    @video.instructor_id = @instructor.id
    if @video.save
      flash[:notice] = "You just created " + @video.title + "!"
      redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      redirect_to root_url
    end
  end

  def update
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:id])
    if @video.update_attributes(video_params)
      flash[:notice] = "You just updated " + @video.title + "!"
      redirect_to instructor_course_track_video_path(@instructor, @course, @track, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      redirect_to root_url
    end
  end

  def destroy
    @course = Course.friendly.find(params[:course_id])
    @track = Track.friendly.find(params[:track_id])
    @video = Video.friendly.find(params[:id]).destroy
    redirect_to instructor_course_path(@instructor, @course)
  end

  private

    def video_params
      params.require(:video).permit(:title, :description, :video, :remove_video)
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

    def correct_video_instructor
      @course = Course.friendly.find(params[:course_id])
      @track = Track.friendly.find(params[:track_id])
      @video = Video.friendly.find(params[:id])
      redirect_to instructor_path(@course.instructor_id) if @video.instructor_id != current_instructor.id
    end

end