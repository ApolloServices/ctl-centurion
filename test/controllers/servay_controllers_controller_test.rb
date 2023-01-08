require 'test_helper'

class ServayControllersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @servay_controller = servay_controllers(:one)
  end

  test "should get index" do
    get servay_controllers_url
    assert_response :success
  end

  test "should get new" do
    get new_servay_controller_url
    assert_response :success
  end

  test "should create servay_controller" do
    assert_difference('ServayController.count') do
      post servay_controllers_url, params: { servay_controller: {  } }
    end

    assert_redirected_to servay_controller_url(ServayController.last)
  end

  test "should show servay_controller" do
    get servay_controller_url(@servay_controller)
    assert_response :success
  end

  test "should get edit" do
    get edit_servay_controller_url(@servay_controller)
    assert_response :success
  end

  test "should update servay_controller" do
    patch servay_controller_url(@servay_controller), params: { servay_controller: {  } }
    assert_redirected_to servay_controller_url(@servay_controller)
  end

  test "should destroy servay_controller" do
    assert_difference('ServayController.count', -1) do
      delete servay_controller_url(@servay_controller)
    end

    assert_redirected_to servay_controllers_url
  end
end
