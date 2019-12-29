require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:example)
    @post = @user.posts.create(title: "Example title", body: "Example body")
  end

  test "should get index" do
    get posts_path
    assert_response :success
  end

  test "should redirect from show to index" do
    get post_path(@post)
    assert_redirected_to posts_path
  end

  test "should redirect from new to index if not logged in" do
    get new_post_path
    assert_redirected_to posts_path
  end

  test "should get new path if logged in" do
    log_in_as(@user)
    get new_post_path
    assert_response :success
  end

  test "should redirect from create to index if not logged in" do
    assert_no_difference -> { Post.count } do
      post posts_path, params: { post: { title: "Title",
                                         body: "Body" } }
    end
    assert_redirected_to posts_path
  end

  test "should create new post if logged in" do
    log_in_as(@user)
    assert_difference -> { Post.count }, 1 do
      post posts_path, params: { post: { title: "Title",
                                         body: "Body" } }
    end
    assert_redirected_to posts_path
  end

  test "should redirect from edit to index if not logged in" do
    get edit_post_path(@post)
    assert_redirected_to posts_path
  end

  test "should get edit if logged in" do
    log_in_as(@user)
    get edit_post_path(@post)
    assert_response :success
  end

  test "should redirect from update if not logged in" do
    assert_no_changes -> { @post } do
      patch post_path(@post), params: { post: { title: "A different title" } }
    end
    assert_redirected_to posts_path
  end

  test "should redirect from destroy if not logged in" do
    assert_no_difference -> { Post.count } do
      delete post_path(@post)
    end
    assert_redirected_to posts_path
  end
end
