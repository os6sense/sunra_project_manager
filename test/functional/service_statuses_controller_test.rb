require 'test_helper'

class ServiceStatusesControllerTest < ActionController::TestCase
  setup do
    @service_status = service_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_status" do
    assert_difference('ServiceStatus.count') do
      post :create, service_status: {  }
    end

    assert_redirected_to service_status_path(assigns(:service_status))
  end

  test "should show service_status" do
    get :show, id: @service_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_status
    assert_response :success
  end

  test "should update service_status" do
    put :update, id: @service_status, service_status: {  }
    assert_redirected_to service_status_path(assigns(:service_status))
  end

  test "should destroy service_status" do
    assert_difference('ServiceStatus.count', -1) do
      delete :destroy, id: @service_status
    end

    assert_redirected_to service_statuses_path
  end
end
