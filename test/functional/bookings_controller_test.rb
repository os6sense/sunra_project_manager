require 'test_helper'
require 'date'

require 'warden_helper'

include ActionDispatch::Routing::UrlFor
include Rails.application.routes.url_helpers

include Devise::TestHelpers

class BookingsControllerTest < ActionController::TestCase
  def _set_path_hash
    @path_hash = {project_id: @p_id, id: @b_id}
  end

  # ========================================================
  # INDEX
  # ========================================================
  def get_index(p_id=nil)
    get :index, p_id
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "def! should get index (nested)" do
    get_index :project_id => @p_id
  end

  test "def! should get index (unnested)" do
    get_index
  end

  # ========================================================
  # NEW
  # ========================================================
  test "should get new" do
    _get :new, @p_id
    assert_response :success
  end

  # ========================================================
  # CREATE
  # ========================================================
  test "should create booking" do
    _set_ids
    assert_difference('Booking.count') do
      post :create,
        :project_id => @p_id,
        :booking => { :facility_studio => 1,
                   :date => Date.today+1,
                   :start_time => "#{Date.today+1} 12:00:00",
                   :end_time => "#{Date.today+1} 23:00:00"}
    end

    assert_not_nil assigns(:booking)

    #assert_redirected_to polymorphic_path([@p_id, booking])

    assert_not_nil Booking.find_by_date(Date.today+1), 
      "should find booking by date"
    assert_not_nil Booking.where("start_time = '#{Date.today+1} 12:00:00'"),
      "should find booking by start_time"
    assert_empty Booking.where("start_time = '#{Date.today+1} 11:00:00'"),
      "should NOT find booking by start_time"
    assert_not_nil Booking.where("end_time = '#{Date.today+1} 23:00:00'"),
      "should find booking by end_time"
  end

  # ========================================================
  # SHOW
  # ========================================================
  test "should show booking - nested" do
    _get :show
  end

  test "should show booking - unnested" do
    _get :show, @b_id
  end

  # ========================================================
  # EDIT
  # ========================================================
  test "should get edit - nested" do
    _get :edit
  end

  test "should get edit - unnested" do
    _get :edit, @b_id
  end

  # ========================================================
  # UPDATE
  # ========================================================
  test "should update booking" do
    _set_ids
    updated_date = "#{Date.today+2}" 
    updated_start = "#{Date.today+2} 12:30:00" 
    updated_end = "#{Date.today+2} 22:30:00" 

    put :update, 
      :project_id => @p_id,
      :id => @b_id, 
      :booking => { :date => updated_date, 
      :start_time => updated_start,
      :end_time => updated_end }

#    assert_response :success
    assert_not_nil Booking.find_by_date(updated_date), 
      "should find updated booking by date"
    assert_not_nil Booking.where("start_time = '#{updated_start}'"),
      "should find updated booking by start_time"
  end

  # ========================================================
  # DELETE
  # ========================================================
  def _delete id_hash
    assert_difference('Booking.count', -1) do
      delete :destroy, id_hash
    end

    assert_nil Booking.find_by_id @b_id , "No booking should be found"
  end

  test "should destroy booking - nested" do
    _set_ids
    _set_path_hash
    _delete  @path_hash
    assert_redirected_to project_bookings_path(@p_id)
  end

  test "should destroy booking - unnested" do
    _set_ids
    _delete id: @b_id
    assert_redirected_to bookings_path
  end
end
