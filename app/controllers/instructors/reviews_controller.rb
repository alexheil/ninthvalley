class Instructors::ReviewsController < ApplicationController

  def create
    @comment = ArtistMicropostComment.new(comment_params)
    @comment.artist_micropost_id = ArtistMicropost.find(params[:micropost_id]).id
    @artist = Artist.friendly.find(ArtistMicropost.find(params[:micropost_id]).artist_id)
    @micropost = ArtistMicropost.find(params[:micropost_id])
    if artist_signed_in?
      @comment.artist_id = current_artist.id
    elsif fan_signed_in?
      @comment.fan_id = current_fan.id
    elsif record_label_signed_in?
      @comment.record_label_id = current_record_label.id
    elsif venue_signed_in?
      @comment.venue_id = current_venue.id
    elsif producer_signed_in?
      @comment.producer_id = current_producer.id
    end
    if @comment.save
      flash.now[:notice] = "you posted a comment on #{@artist.artist_name}'s status."
      create_notification(@micropost, @comment)
      send_comment_email
      #respond_to do |format|
        format.html { redirect_to (:back) }
        format.js { render :action => "comments" }
      end
    else
      redirect_to (:back)
      flash[:alert] = "you suck."
    end
  end

  def update
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end