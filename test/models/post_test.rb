require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @post = @user.posts.create(title: "Post title", body: "Post body")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should not accept empty title" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "should not accept whitespace title" do
    @post.title = "     "
    assert_not @post.valid?
  end

  test "should not accept title longer than 255 characters" do
    @post.title = "a" * 256
    assert_not @post.valid?
  end

  test "should not accept empty body" do
    @post.body = ""
    assert_not @post.valid?
  end

  test "should not accept whitespace body" do
    @post.body = "     "
    assert_not @post.valid?
  end

  test "should not accept body longer than 40_000 characters" do
    @post.body = "a" * 40_001
    assert_not @post.valid?
  end

  test "should not accept post without a user_id" do
    @post.user_id = nil
    assert_not @post.valid?
  end
end
