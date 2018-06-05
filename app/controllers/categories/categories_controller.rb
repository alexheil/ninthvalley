class Categories::CategoriesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @categories = Category.all
    @popular_courses = Course.left_joins(:purchases).group(:id).order('COUNT(purchases.id) DESC').limit(8)
  end

  def show
    @category = Category.friendly.find(params[:id])
    @popular_courses = @category.courses.left_joins(:purchases).group(:id).order('COUNT(purchases.id) DESC').limit(8)
    @recent_courses = @category.courses.reorder("created_at desc").limit(4)
    @subcategories = @category.subcategories
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "You just created " + @category.title + "!"
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "Good job!"
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @category = Category.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def authenticate_admin!
      unless instructor_signed_in? && current_instructor == Instructor.find(1)
        redirect_to root_url
        flash[:notice] = "You do not have access to this page."
      end
    end

    def category_params
      params.require(:category).permit(:title, :description, :image)
    end

end
