class BookmarksController < ApplicationController

  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    if @bookmark.save

      redirect_to bookmarks_path, notice: 'Bookmark was created!'
    else
      render :new, alert: 'Error. Could not create.'
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @recipe = @bookmark.recipe
    @comments = @recipe.comments
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:recipe_id)
  end
end
