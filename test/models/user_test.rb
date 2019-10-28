require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example Name", email: "email@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should not accept empty name" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "should not accept whitespace name" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "should not accept name exceeding 255 characters" do
    @user.name = "e" * 256
    assert_not @user.valid?
  end

  test "should not accept empty email" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "should not accept whitespace email" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "should not accept invalid email formats" do
    @user.email = "somethingatexample.com"
    assert_not @user.valid?
    @user.email = "something@exampledotcom"
    assert_not @user.valid?
  end

  test "should not accept email exceeding 255 characters" do
    @user.email = ("e" * 256) + "@example.com"
    assert_not @user.valid?
  end

  test "should enforce email case insensitivity" do
    @user.save
    @second_user = User.new(name: "Another Name", email: "eMaIl@eXamPlE.com",
                            password: "foobar", password_confirmation: "foobar")
    assert_not @second_user.valid?
  end

  test "should downcase email upon save" do
    @user.email = "eMaIl@eXamPlE.com"
    @user.save
    assert_equal "email@example.com", @user.email
  end

  test "should not accept blank password" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "should not accept whitespace password" do
    @user.password = @user.password_confirmation = "     "
    assert_not @user.valid?
  end

  test "should not accept differing password / confirmation" do
    @user.password = "foobar"
    @user.password_confirmation = "foobaz"
    assert_not @user.valid?
  end

  test "should not accept password below minimum length" do
    @user.password = @user.password_confirmation = "e" * 5
    assert_not @user.valid?
  end
end
