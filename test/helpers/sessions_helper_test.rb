require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
    def setup
        @user = users(:example)
        remember(@user)
    end

    test "should log user in" do
        assert_equal @user, current_user
        assert logged_in?
    end

    test "should reject incorrect remember_digest" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_user
    end

    test "should forget user upon logout" do
        log_out
        assert_nil current_user
    end
end