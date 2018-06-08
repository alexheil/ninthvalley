class BlogPostsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @posts = BlogPost.all
  end

  def show
    @post = BlogPost.friendly.find(params[:id])
    @recent_posts = BlogPost.all.reorder("created_at desc").limit(5)
  end

  def new
    @post = BlogPost.new
  end

  def create
    @post = BlogPost.new(blog_post_params)
    if @post.save
      flash[:notice] = "You just created " + @post.title + "!"
      redirect_to blog_post_path(@post)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @post = BlogPost.friendly.find(params[:id])
  end

  def update
    @post = BlogPost.friendly.find(params[:id])
    if @post.update_attributes(blog_post_params)
      flash[:notice] = "Good job!"
      redirect_to blog_post_path(@post)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @post = BlogPost.friendly.find(params[:id]).destroy
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

    def blog_post_params
      params.require(:blog_post).permit(:title, :image, :tagline, :content)
    end

end