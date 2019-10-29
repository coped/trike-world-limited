require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        assert_equal full_title, "Trike World Limited | Dennis Cope"
        assert_equal full_title("Home"), "Home | Trike World Limited | Dennis Cope"
    end
end