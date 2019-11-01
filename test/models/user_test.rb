require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @another_user = users(:another)
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
 
  test "should not accept another user with same email" do
    @user.save
    @another_user.email = "example@user.com"
    assert_not @another_user.valid?
  end

  test "should enforce email case insensitivity" do
    @user.save
    @another_user.email = "eXamPle@uSer.cOm"
    assert_not @another_user.valid?
  end

  test "should downcase email upon save" do
    @user.email = "eMaIl@eXamPlE.com"
    @user.save
    assert_equal "email@example.com", @user.email
  end

  test "should not accept blank password" do
    @blank_user = User.new(name: "Blank User",
                           email: "blank@user.com",
                           password:              "",
                           password_confirmation: "")
    assert_not @blank_user.valid?
  end

  test "should not accept whitespace password" do
    @empty_user = User.new(name: "Empty User",
                           email: "empty@user.com",
                           password:              "     ",
                           password_confirmation: "     ")
    assert_not @empty_user.valid?
  end

  test "should not accept differing password / confirmation" do
    @typo_user = User.new(name: "Typo User",
                          email: "typo@user.com",
                          password:              "foobar",
                          password_confirmation: "foobaz")
    assert_not @typo_user.valid?
  end

  test "should not accept password below minimum length" do
    @short_user = User.new(name: "Short User",
                           email: "short@user.com",
                           password:              "eeeee",
                           password_confirmation: "eeeee")
    assert_not @short_user.valid?
  end

  test "should successfully authenticate a user" do
    @user.password_digest = User.digest("foobar")
    assert @user.authenticates_with?(:password_digest, "foobar")
  end

  test "should not authenticate a bad user" do
    @user.password_digest = User.digest("foobar")
    assert_not @user.authenticates_with?(:password_digest, "foobaz")
  end

  test "should create a reset_digest entry" do
    assert @user.reset_digest.nil?
    @user.create_reset_digest
    assert_not @user.reset_digest.nil?
  end

  test "should create a reset_sent_at entry" do
    assert @user.reset_sent_at.nil?
    @user.create_reset_digest
    assert_not @user.reset_sent_at.nil?
  end

  test "should return first name" do
    assert_equal "Example", @user.first_name
  end

  test "should return true for valid reset" do
    @user.reset_sent_at = Time.zone.now
    assert_not @user.password_reset_expired?
  end

  test "should return false for invalid reset" do
    @user.reset_sent_at = 2.years.ago
    assert @user.password_reset_expired?
  end
end
