class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(recipe: @recipe)
    @comments = @recipe.comments
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)

    if params[:recipe] && params[:recipe][:rating].present?
      @recipe.update(rating: params[:recipe][:rating])
    end

    if @comment.save
      redirect_to new_recipe_comment_path, notice: 'Comment added !'
    else
      flash.now[:alert] = 'Error. Could not create the comment.'
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: recipe_path(@comment.recipe), notice: "Comment was deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
