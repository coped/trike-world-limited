require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @another_user = users(:another)
  end

  test "should redirect from show to static_pages#about" do
    get user_path(@user)
    assert_redirected_to about_path
  end

  test "should redirect from edit to index if not logged in" do
    get edit_user_path(@user)
    assert_redirected_to posts_path
  end

  test "should redirect from edit to index if incorrect user" do
    log_in_as(@another_user)
    get edit_user_path(@user)
    assert_redirected_to posts_path
  end

  test "should redirect from update to index if not logged in" do
    assert_no_changes -> { @user } do 
      patch user_path(@user), params: { user_params: { name: "Different name" } }
    end
    assert_redirected_to posts_path
  end

  test "should redirect from update to index if incorrect user" do
    log_in_as(@another_user)
    assert_no_changes -> { @user } do
      patch user_path(@user), params: { user_params: { name: "Different name" } }
    end
    assert_redirected_to posts_path
  end

end
