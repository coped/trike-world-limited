require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @another_user = users(:another)
  end

  test "posts interface" do
    # When not logged in
    get posts_path
    assert_select "a", text: "Edit", count: 0
    # When logged in
    log_in_as(@user)
    get posts_path
    assert_select "a", text: "Edit"
    get new_post_path
    # Submitting invalid post
    assert_no_difference -> { Post.count } do
      post posts_path, params: { post: { title: "", body: "" } }
    end
    # Submitting valid post
    assert_difference -> { Post.count } do
      post posts_path, params: { post: { title: "A new post!",
                                         body:  "A new post!" } }
    end
    assert_redirected_to posts_path
    follow_redirect!
    post = Post.last
    get edit_post_path(post)
    assert_match post.title, response.body
    assert_match post.body, response.body
    # Submitting invalid post update
    assert_no_changes -> { post.title } do
      patch post_path(post), params: { post: { title: "" } }
      post.reload
    end
    # Submitting valid post update
    assert_changes -> { post.title } do
      patch post_path(post), params: { post: { title: "An updated title" } }
      post.reload
    end
    # Attempting to edit someone else's post
    another_user_post = posts(:another_post)
    assert_no_changes -> { another_user_post.title } do
      patch post_path(another_user_post), params: { post: { title: "An updated title" } }
      another_user_post.reload
    end
    # Deleting post
    assert_difference -> { Post.count }, -1 do
      delete post_path(post)
    end
    # Deleting someone else's post
    assert_no_difference -> { Post.count } do
      delete post_path(another_user_post)
    end
  end
end
