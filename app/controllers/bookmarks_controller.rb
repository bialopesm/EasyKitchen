class BookmarksController < ApplicationController

  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
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
