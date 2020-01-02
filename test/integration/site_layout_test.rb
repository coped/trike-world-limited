require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "home page" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "title", full_title("Home")
    assert_select "nav", count: 1, class: "navbar"
    assert_select "aside", count: 1, class: "menu"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", galleries_charles_path, count: 2
    assert_select "a[href=?]", galleries_tim_path, count: 2
    assert_select "a[href=?]", galleries_red_trike_path, count: 2
    assert_select "a[href=?]", galleries_roth_body_path, count: 2
    assert_select "a[href=?]", galleries_twin_turbo_path, count: 2
    assert_select "a[href=?]", galleries_misc_path, count: 2
  end
end
