require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "invalid user login" do
    get posts_path
    assert_select "a[href=?]", login_path
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { login: { email: "",
                                        password: "" }}
    assert_not flash.empty?
    get posts_path
    assert_template 'posts/index'
    assert flash.empty?
    assert_select "a[href=?]", login_path
  end

  test "valid user login with logout" do
    get posts_path
    assert_select "a[href=?]", login_path
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { login: { email: @user.email,
                                        password: "foobar" }}
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'
    assert flash.empty?
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'
    assert_select "a[href=?]", login_path
  end

  test "user login without remembering" do
    post login_path, params: { login: { email: @user.email,
                                       password: "foobar",
                                       remember: "0" }}
    assert_nil assigns(:user).remember_token
    assert_nil cookies[:remember_token]
  end

  test "user login with remembering" do
    post login_path, params: { login: { email: @user.email,
                                        password: "foobar",
                                        remember: "1" }}
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
end
