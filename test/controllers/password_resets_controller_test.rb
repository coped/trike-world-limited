require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end
  
  test "should get new" do
    get new_password_reset_path
    assert_response :success
  end

  test "should get edit" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_response :success
  end

end
