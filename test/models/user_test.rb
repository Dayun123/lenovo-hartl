require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "Example@aol.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = '    '
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ' '
    assert_not @user.valid?
  end

  # Arbitrarily picked 50 as the upper bound for name length. This will make sure that a name of length 51 is invalid.
  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  # The max length of a string in some DB's is 255, so this will test that a string of 256 characters is invalid
  test "email should not be too long" do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

end
