class StaticPagesController < ApplicationController

  before_action :redirect_if_signed_in, only: [:register, :sign_in]

  def home
  end

  def privacy
  end

  def terms
  end

  def about
  end

  def sign_in
  end

  def register
  end

  def courses
    @courses = Courses.search(params[:search]).order("created_at DESC").page params[:page]
  end

  private

    def redirect_if_signed_in
      if instructor_signed_in? || student_signed_in?
        redirect_to root_url
        flash[:notice] = " You are already signed in!"
      end
    end

end