class HomePageController < ApplicationController
  def index
    @messages = Comment.all
  end

  def create
    Comment.create(comment_params)
    @messages = Comment.all
  end

  def comment_params
    params.require(:comment).permit!
  end
end
