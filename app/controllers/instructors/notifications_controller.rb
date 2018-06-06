class Instructors::NotificationsController < ApplicationController

  before_action :authenticate_instructor!
  before_action :correct_instructor
  before_action :set_instructor

  def update
    @notification = Notification.find(params[:id])
    @notifications = @instructor.notifications
    if @notification.update_attributes(read: true)
      respond_to do |format|
        format.html { redirect_to instructor_path(@instructor) }
        format.js { render :action => "notifications" }
        flash.now[:notice] = "Marked read."
      end
    else
      redirect_to current_instructor
      flash[:alert] = "Not working."
    end
  end

  def destroy
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @notification = Notification.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to redirect_to instructor_path(@instructor) }
      format.js { render :action => "notifications" }
      flash.now[:notice] = "Notification deleted."
    end
  end

  private

    def set_instructor
      @instructor = current_instructor
    end

    def correct_instructor
      @instructor = Instructor.friendly.find(params[:instructor_id])
      unless current_instructor == @instructor
        redirect_to instructor_path(@instructor)
        flash.now[:alert] = "This is not your profile."
      end
    end

end
