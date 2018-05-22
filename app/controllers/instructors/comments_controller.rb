class Instructors::CommentsController < ApplicationController

  def create
  end

  def update
  end

  def destroy
  end

  private

    def comment_params
      params.require(:course).permit(:content)
    end

end