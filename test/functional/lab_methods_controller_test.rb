require 'test_helper'

class LabMethodsControllerTest < ActionController::TestCase
  setup do
    @lab_method = lab_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lab_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lab_method" do
    assert_difference('LabMethod.count') do
      post :create, lab_method: @lab_method.attributes
    end

    assert_redirected_to lab_method_path(assigns(:lab_method))
  end

  test "should show lab_method" do
    get :show, id: @lab_method
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lab_method
    assert_response :success
  end

  test "should update lab_method" do
    put :update, id: @lab_method, lab_method: @lab_method.attributes
    assert_redirected_to lab_method_path(assigns(:lab_method))
  end

  test "should destroy lab_method" do
    assert_difference('LabMethod.count', -1) do
      delete :destroy, id: @lab_method
    end

    assert_redirected_to lab_methods_path
  end
end
