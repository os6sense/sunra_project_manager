require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  test "WILL NOT create an empty Admin" do
	  a = Admin.new
    assert !a.save
  end

  test "WILL Create Admin with valid login and password" do
  	a = Admin.new
	  a.email = "test@test.com"
	  a.password = "testpassword"
	  assert a.save
  end

  test "WILL Create Admin and create an authentication_token after save" do
  	a = Admin.new
	  a.email = "test@test.com"
	  a.password = "testpassword"
	  assert a.save
    assert a.authentication_token != nil
  end

end
