class Instructors::PostsController < ApplicationController

  before_action :authenticate_instructor!, except: :show
  before_action :correct_instructor, only: :create
  before_action :correct_post_instructor, only: [:update, :destroy]
  before_action :set_instructor, except: :show

  def show
    @instructor = Instructor.friendly.find(params[:instructor_id])
    @post = Post.friendly.find(params[:id])
  end

  def create
    @post = @instructor.posts.build(post_params)
    if @post.save
      flash[:notice] = "You just created " + @post.title + "!"
      redirect_to instructor_path(@instructor, @post)
      send_student_email
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "You just updated " + @post.title + "!"
      redirect_to instructor_post_path(@instructor, @post)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id]).destroy
    redirect_to instructor_path(@instructor)
    flash[:notice] = "You deleted your post. "
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :image, :remove_image)
    end

    def set_instructor
      @instructor = current_instructor
    end

    def correct_instructor
      @instructor = Instructor.friendly.find(params[:instructor_id])
      if current_instructor != @instructor
        redirect_to instructor_path(@instructor)
        flash[:alert] = "This is not your profile."
      end
    end

    def correct_post_instructor
      @post = post.friendly.find(params[:id])
      redirect_to instructor_path(@post.instructor_id) if @post.instructor_id != current_instructor.id
    end

    def send_student_email
      @instructor.subscriptions.find_each do |subscription|
        StudentMailer.post_email(subscription.student, @instructor, @subscription, @post).deliver_now unless subscription.student.post_email == false
      end
    end

end