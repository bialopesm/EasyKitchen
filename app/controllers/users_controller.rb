class UsersController < ApplicationController
  def show
    @user = current_user
    @recipes = @user.recipes.includes(:bookmarks)
  end
end
