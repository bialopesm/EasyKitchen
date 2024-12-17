class BookmarksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_bookmark, only: [:show, :destroy]

  def index
    @bookmarks = current_user.bookmarks.joins(:recipe).order('recipes.id DESC')
    if params[:done].present?
      @bookmarks = @bookmarks.where(recipes: { done: params[:done] })
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @recipe = @bookmark.recipe
    @comments = @recipe.comments
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
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
