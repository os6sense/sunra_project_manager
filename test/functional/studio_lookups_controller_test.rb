require 'test_helper'
require 'warden_helper'

include ActionDispatch::Routing::UrlFor
include Rails.application.routes.url_helpers

#include Devise::TestHelpers

class StudioLookupsControllerTest < ActionController::TestCase
  def _set_path_hash
    @path_hash = {project_id: @p_id, id: @b_id}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studio_lookups)
  end

  # ========================================================
  # INDEX
  # ========================================================
  test "should get new" do
    get :new
    assert_response :success
  end

  # ========================================================
  # CREATE
  # ========================================================
  test "should create studio_lookup" do
    assert_difference('StudioLookup.count') do
      post :create,
        :studio_lookup => {
          :facility_name => "Richmond",
          :studio_name => "testing",
          :mdns_localname => "somewhere.local",
          :ip_fallback => "192.168.0.1",
          :phone => "020800000000",
          :active => true
        }
    end

    assert_redirected_to studio_lookup_path(assigns(:studio_lookup))

    assert_not_nil StudioLookup.find_by_studio_name("testing")
  end

  # ========================================================
  # SHOW
  # ========================================================
  test "should show studio_lookup" do
    _set_ids
    get :show, :id => @sl_id
    assert_response :success
  end

  # ========================================================
  # EDIT
  # ========================================================
  test "should get edit" do
    _set_ids
    get :edit, :id => @sl_id
    assert_response :success
  end

  # ========================================================
  # UPDATE
  # ========================================================
  test "should update studio_lookup" do
    _set_ids
    put :update, 
      :id => @sl_id, 
      :studio_lookup => { :studio_name => "changedname" }
    assert_redirected_to studio_lookup_path(assigns(:studio_lookup))
    assert_not_nil StudioLookup.find_by_studio_name("changedname")
  end

  # ========================================================
  # DELETE
  # ========================================================
  test "should destroy studio_lookup" do
    _set_ids
    assert_difference('StudioLookup.count', -1) do
      delete :destroy, :id => @sl_id
    end

    assert_redirected_to studio_lookups_path
  end
end
