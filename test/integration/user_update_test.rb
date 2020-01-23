require 'test_helper'

class UserUpdateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "user update" do
    log_in_as(@user)
    get user_path(@user)
    # Updating user attributes
    new_name = "New Name"
    new_password = "hunter2"
    new_avatar = fixture_file_upload("test/fixtures/rails-logo.svg", "image/svg")
    assert_changes -> { @user.password_digest } do
      patch user_path(@user), params: { user: { name: new_name,
                                                password: new_password,
                                                password_confirmation: new_password,
                                                avatar: new_avatar } }
      @user.reload
    end
    assert_equal @user.name, new_name
    assert @user.avatar.attached?
    assert_redirected_to edit_user_path(@user)
    # Updating user attributes without avatar won't remove existing avatar
    assert_no_changes -> { @user.avatar.attached? } do
      patch user_path(@user), params: { user: { name: "An even newer name" }}
    end
  end
end
