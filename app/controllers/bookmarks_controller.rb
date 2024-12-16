class BookmarksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_bookmark, only: [:show, :destroy]

  def index
    @bookmarks = current_user.bookmarks
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @recipe = @bookmark.recipe
    @comments = @recipe.comments
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path, notice: "Recipe removed."
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:recipe_id)
  end
end
