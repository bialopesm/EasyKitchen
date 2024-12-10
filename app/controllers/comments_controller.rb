class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @bookmark = Bookmark.find(params[:bookmark_id])
    @comment = Comment.new(bookmark: @bookmark)
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @comment = @bookmark.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to bookmark_path(@bookmark), notice: 'It was created!'
    else
      render :new, alert: 'Error. Could not create.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
