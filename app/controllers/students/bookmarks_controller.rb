class Students::BookmarksController < ApplicationController

  def create
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @bookmark = Bookmark.new
    @bookmark.student_id = @student.id
    @bookmark.course_id = @course.id
    if @bookmark.save
      respond_to do |format|
        format.html { redirect_to instructor_course_path(@instructor, @course) }
        format.js { render :action => "notifications" }
        flash.now[:notice] = "You have successfully bookmarked #{@course.title}!"
      end
    else
      redirect_to instructor_course_path(@instructor, @course)
      flash[:alert] = "You have failed."
    end
  end

  def destroy
    @student = current_student
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @course = Course.friendly.find(params[:course_id])
    @student.unbookmark(@course)
    redirect_to instructor_course_path(@instructor, @course)
    flash[:notice] = "You unbookmarked #{@course.title}!"
  end

end