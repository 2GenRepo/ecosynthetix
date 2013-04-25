require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get username:string" do
    get :username:string
    assert_response :success
  end

  test "should get password:string" do
    get :password:string
    assert_response :success
  end

  test "should get first_name:string" do
    get :first_name:string
    assert_response :success
  end

  test "should get last_name:string" do
    get :last_name:string
    assert_response :success
  end

  test "should get facility:integer" do
    get :facility:integer
    assert_response :success
  end

  test "should get email_address:string" do
    get :email_address:string
    assert_response :success
  end

  test "should get roles:string" do
    get :roles:string
    assert_response :success
  end

  test "should get options:string" do
    get :options:string
    assert_response :success
  end

end
