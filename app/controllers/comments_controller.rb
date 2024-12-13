class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(recipe: @recipe)
    @comments = Comment.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)


    if @comment.save
      redirect_to recipes_path, notice: 'It was created!'
    else
      render :new, alert: 'Error. Could not create.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
