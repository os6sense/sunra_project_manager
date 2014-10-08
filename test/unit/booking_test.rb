require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  setup do
    @project = projects(:one)
    assert_instance_of(Project, @project)
  end

  # ========================================================
  test "WILL NOT create an empty booking" do
    b = Booking.new
    assert !b.save
  end

  def set_date! booking, date
    booking.date = date
    booking.start_time = "#{booking.date} 12:00:00"
    booking.end_time = "#{booking.date} 20:00:00"
  end
  # ========================================================
  test "WILL add a booking to an existing project" do
    booking = @project.bookings.new
    booking.facility_studio = 1
    set_date!( booking, Date.today+1 )
    assert booking.save
  end
  # ========================================================
  test "WILL add a booking with availability notes to an existing project" do
    booking = @project.bookings.new
    booking.facility_studio = 1
    set_date!( booking, Date.today+1 )
    booking.availability_notes = "Wants from 3pm onwards"
    assert booking.save
  end

  # ========================================================
  test "Will NOT add a booking in the past" do
    booking = @project.bookings.new
    booking.facility_studio = 1
    set_date!( booking, Date.today-1 )
    assert !booking.save
  end

  test "Will create a booking for today" do
    booking = @project.bookings.new
    booking.facility_studio = 1
    set_date!( booking, Date.today )
    assert booking.save, "Failed to save a booking for today"
  end

  test "Will NOT accept bookings that overlap for the same studio" do
    booking = @project.bookings.new
    date = Date.today+5
    booking.facility_studio = 1
    set_date!( booking, date )
    assert booking.save

    booking = @project.bookings.new
    booking.facility_studio = 1
    booking.date = date
    booking.start_time = "#{booking.date} 14:00:00"
    booking.end_time = "#{booking.date} 22:00:00"
    assert !booking.save, "Error, saved an overlapping booking"

    booking = @project.bookings.new
    booking.facility_studio = 1
    booking.date = date
    booking.start_time = "#{booking.date} 08:00:00"
    booking.end_time = "#{booking.date} 13:00:00"
    assert !booking.save, "Error, saved an overlapping booking"
  end
end
