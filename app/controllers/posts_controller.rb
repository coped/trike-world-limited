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
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.valid?
      @post.save
      @post.image.attach(post_params[:image])
      flash[:info] = "Post successfully created."
      redirect_to posts_path
    else
      flash.now[:warning] = @post.errors.full_messages.to_sentence
      render 'posts/new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:info] = "Post successfully updated"
      redirect_to posts_path
    else
      flash.now[:warning] = @post.errors.full_messages.to_sentence
      render 'posts/edit'
    end
  end

  def destroy
    @post.image.purge
    @post.destroy
    flash[:info] = "'#{@post.title}' was deleted."
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def is_post_author?
      @post = Post.find_by(id: params[:id])
      redirect_to posts_path if current_user != @post.user
    end
end
