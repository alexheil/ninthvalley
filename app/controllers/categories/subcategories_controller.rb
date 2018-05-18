class Categories::SubcategoriesController < ApplicationController

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
    @category = Category.new(subcategory_params)
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
    if @category.update_attributes(subcategory_params)
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

    def subcategory_params
      params.require(:category).permit(:title, :description, :image)
    end

end
