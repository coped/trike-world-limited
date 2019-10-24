require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root page" do
    get root_path
    assert_response :success
  end

  test "should get about page" do
    get about_path
    assert_response :success
  end

  test "should get contact page" do
    get contact_path
    assert_response :success
  end

  test "should get charles gallery page" do
    get galleries_charles_path
    assert_response :success
  end
  
  test "should get tim gallery page" do
    get galleries_tim_path 
    assert_response :success
  end

  test "should get red trike gallery page" do
    get galleries_red_trike_path
    assert_response :success
  end

  test "should get roth body gallery page" do
    get galleries_roth_body_path
    assert_response :success
  end
  
  test "should get twin turbo gallery page" do
    get galleries_twin_turbo_path
    assert_response :success
  end

  test "should get misc gallery page" do
    get galleries_misc_path
    assert_response :success
  end
end
