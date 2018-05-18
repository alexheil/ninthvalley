class Categories::CategoriesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @categories = Category.all
    @recent_posts = Post.reorder("created_at desc").limit(5)
  end

  def show
    @categories = Category.all
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts.page params[:page]
    @top_post = @category.posts.last
    @recent_posts = Post.reorder("created_at desc").limit(5)
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
