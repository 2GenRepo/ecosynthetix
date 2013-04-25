require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get quality" do
    get :quality
    assert_response :success
  end

  test "should get reporting" do
    get :reporting
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

end
