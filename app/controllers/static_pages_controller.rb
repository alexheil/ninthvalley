class StaticPagesController < ApplicationController
  layout "home", only: :home

  before_action :redirect_if_signed_in, only: [:register, :sign_in]

  def home
    @popular_courses = Course.all.left_joins(:purchases).group(:id).order('COUNT(purchases.id) DESC').limit(4)
    @categories = Category.all
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

  private

    def redirect_if_signed_in
      if instructor_signed_in? || student_signed_in?
        redirect_to root_url
        flash[:notice] = " You are already signed in!"
      end
    end

end