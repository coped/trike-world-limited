class PostsController < ApplicationController
  before_action :is_logged_in?,   only: [:new, :create, :edit, :update, :destroy]
  before_action :is_post_author?, only: [:edit, :update, :destroy]

  def index
    @posts = Post.index_by_most_recent
  end

  def show
    redirect_to posts_path
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      flash[:info] = "Post successfully created."
      redirect_to posts_path
    else
      flash.now[:warning] = @post.errors.full_messages.to_sentence
      render 'posts/new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:info] = "Post successfully updated"
      redirect_to posts_path
    else
      flash.now[:warning] = @post.errors.full_messages.to_sentence
      render 'posts/edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:info] = "'#{@post.title}' was deleted."
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end

    def is_logged_in?
      redirect_to posts_path if !current_user
    end

    def is_post_author?
      redirect_to posts_path if current_user != @post.user
    end
end
