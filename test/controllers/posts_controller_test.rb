require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_path
    assert_response :success
  end

  # test "should get show" do
  #   get post_path(@post)
  #   assert_response :success
  # end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_post_path(@post)
  #   assert_response :success
  # end

end