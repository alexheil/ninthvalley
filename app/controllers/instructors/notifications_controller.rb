class Instructors::NotificationsController < ApplicationController

  before_action :authenticate_instructor!
  before_action :correct_instructor
  before_action :set_instructor

  def update
    @notification = Notification.find(params[:id])
    #@notifications = @instructor.notifications
    if @notification.update_attributes(read: true)
      redirect_to instructor_path(@instructor)
      flash.now[:notice] = "Marked read."
      #respond_to do |format|
      #  format.html { redirect_to instructor_notifications_path(current_instructor) }
      #  format.js { render :action => "notifications" }
      #end
    else
      redirect_to current_instructor
      flash[:alert] = "Not working."
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
