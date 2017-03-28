class HomePageController < ApplicationController
  def index
    @messages = Comment.all.order("created_at desc").page(params[:page]).per(4)
  end

  def create
    Comment.create(comment_params)
    @messages = Comment.all.order("created_at desc").page(params[:page]).per(4)
  end

  def load_more
    @messages = Comment.all.order("created_at desc").page(params[:page]).per(4)
  end

  def comment_params
    params.require(:comment).permit!
  end
end
