require 'test_helper'

class ServaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @servay = servays(:one)
  end

  test "should get index" do
    get servays_url
    assert_response :success
  end

  test "should get new" do
    get new_servay_url
    assert_response :success
  end

  test "should create servay" do
    assert_difference('Servay.count') do
      post servays_url, params: { servay: {  } }
    end

    assert_redirected_to servay_url(Servay.last)
  end

  test "should show servay" do
    get servay_url(@servay)
    assert_response :success
  end

  test "should get edit" do
    get edit_servay_url(@servay)
    assert_response :success
  end

  test "should update servay" do
    patch servay_url(@servay), params: { servay: {  } }
    assert_redirected_to servay_url(@servay)
  end

  test "should destroy servay" do
    assert_difference('Servay.count', -1) do
      delete servay_url(@servay)
    end

    assert_redirected_to servays_url
  end
end
