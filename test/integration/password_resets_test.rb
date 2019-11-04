require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:example)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Submit invalid email
    post password_resets_path, params: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Submit valid email
    post password_resets_path, params: { email: @user.email }
    assert_equal 1, ActionMailer::Base.deliveries.count
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_not flash.empty?
    assert_redirected_to login_path
    # Password reset form
    user = assigns(:user)
    # Submit invalid email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to login_path
    assert_not flash.empty?
    # Submit invalid reset_token
    get edit_password_reset_path(User.new_token, email: user.email)
    assert_redirected_to login_path
    assert_not flash.empty?
    # Submit valid edit parameters
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    # Submit differing passwords
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password:              "foobar",
                                                                   password_confirmation: "foobaz" }}
    assert_template 'password_resets/edit'
    assert_select "div#error-messages"
    # Submit passwords under minimum char limit
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password:              "foobar",
                                                                   password_confirmation: "foobaz" }}
    assert_template 'password_resets/edit'
    assert_select "div#error-messages"
    # Submit empty passwords
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password:              "foobar",
                                                                   password_confirmation: "foobaz" }}
    assert_template 'password_resets/edit'
    assert_select "div#error-messages"

    # Submit valid update parameters
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password:              "foobaz",
                                                                   password_confirmation: "foobaz" }}
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    assert_not_equal user.password_digest, user.reload.password_digest
    assert_nil user.reset_digest
    assert_nil user.remember_digest
  end
end
