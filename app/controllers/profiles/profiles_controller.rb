class Profiles::ProfilesController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user

  def edit
    if instructor_signed_in?
      @instructor = current_instructor
      @profile = @instructor.profile
    elsif student_signed_in?
      @student = current_student
      @profile = @student.profile
    end
  end

  def update
    if instructor_signed_in?
      @instructor = current_instructor
      @profile = @instructor.profile
    elsif student_signed_in?
      @student = current_student
      @profile = @student.profile
    end
    if @result = @profile.update_attributes(profile_params)
      redirect_to (:back)
      flash[:notice] = "Updated."
      #respond_to do |format|
      #  format.html { redirect_to (:back) }
      #  format.js { render :action => "profiles" }
      #  flash.now[:notice] = "You have successfully updated your profile."
      #end
    else
      redirect_to root_url
      #respond_to do |format|
      #  format.html { redirect_to (:back) }
      #  format.js { render :action => "profiles" }
      #  flash.now[:alert] = "You've failed to update your profile."
      #end
    end
  end

  private

    def authenticate_user!
      if instructor_signed_in?
        authenticate_instructor!
      elsif student_signed_in?
        authenticate_student!
      end
    end

    def correct_user
      if instructor_signed_in?
        @instructor = Instructor.friendly.find(params[:instructor_id])
        if current_instructor != @instructor
          redirect_to instructor_path(@instructor)
          flash[:alert] = "This is not your profile."
        end
      elsif student_signed_in?
        @student = Student.friendly.find(params[:student_id])
        if current_student != @student
          redirect_to student_path(@student)
          flash[:alert] = "This is not your profile."
        end
      end
    end

    def profile_params
      params.require(:profile).permit(:biography, :first_name, :last_name, :website, :city, :state, :country, :twitter_handle, :twitter_url, :youtube_handle, :youtube_url, :image, :remove_image)
    end

end