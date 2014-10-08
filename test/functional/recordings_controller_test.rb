require 'test_helper'
require 'warden_helper'

include ActionDispatch::Routing::UrlFor
include Rails.application.routes.url_helpers

include Devise::TestHelpers

class RecordingsControllerTest < ActionController::TestCase
  def _set_path_hash
    @path_hash = {project_id: @p_id, booking_id: @b_id, id: @r_id}
  end

  # ========================================================
  # INDEX
  # ============r===========================================
  def get_index(b_id=nil)
    get :index, b_id
    assert_response :success
    assert_not_nil assigns(:recordings)
  end

  test "should get index (nested)" do
    get_index :booking_id => @b_id
  end

  test "should get index (unnested)" do
    get_index 
  end

  # ========================================================
  # NEW
  # ========================================================
  test "should get new (**MUST** BE NESTED)" do
    _get :new
  end

  # ========================================================
  # CREATE
  # ========================================================
  test "should create recording" do
    _set_ids
    assert_difference('Recording.count') do
      post :create,
        :project_id => @p_id,
        :booking_id => @b_id,
        :recording => {
          :start_time => "2014/01/14 16:20:00",
          :end_time => "2014/01/14 17:20:00",
          :group_number => 1,
          :base_filename => "2014-01-14-162000"
      }
    end

    assert_not_nil assigns(:recording)

    assert_not_nil Recording.find_by_base_filename("2014-01-14-162000"),
      "after create, should find Recording by base_filename"
  end

  # ========================================================
  # SHOW
  # ========================================================
  test "should show recording - nested" do
    _get :show
  end

  test "should show recording - unnested" do
    _get :show, @r_id
  end

  # ========================================================
  # EDIT
  # ========================================================
  test "should get edit - nested" do
    _get :edit
  end

  test "should get edit - unnested" do
    _get :edit, @r_id
  end

  # ========================================================
  # UPDATE
  # ========================================================
  test "should update recording" do
    _set_ids
    put :update,
      :project_id => @p_id,
      :booking_id => @b_id,
      :id => @r_id,
      :recording => {
        :base_filename => "2014-01-14-162011"
      }
    #assert_redirected_to recording_path(assigns(:recording))
    assert_not_nil assigns(:recording)
    assert_not_nil Recording.find_by_base_filename("2014-01-14-162011"),
      "after update, should find Recording by base_filename"
  end

  # ========================================================
  # DELETE
  # ========================================================
  def _delete id_hash
    assert_difference('Recording.count', -1) do
      delete :destroy, id_hash
    end

    assert_nil Recording.find_by_id @r_id , "No recording should be found"
  end

  test "should destroy recording - nested" do
    _set_ids
    _set_path_hash
    _delete @path_hash

    assert_redirected_to "#{project_bookings_path(@p_id)}/#{@b_id}"
  end

  test "should destroy recording - unnested" do
    _set_ids
    _delete id: @r_id
    assert_redirected_to recordings_path
  end
end
