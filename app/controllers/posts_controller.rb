class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @categories = @post.categories
    @users = []
    @post.comments.all.each do |comment|
      @user = User.find_by(username: comment.user.username)
      if !@users.include?(@user)
        @users << @user
      end
    end
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end
  
 

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
  end
end
