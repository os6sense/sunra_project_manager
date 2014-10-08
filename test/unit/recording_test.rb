require 'test_helper'

class RecordingTest < ActiveSupport::TestCase

	def setup
    @project = projects(:one)
    assert_instance_of(Project, @project)
	end

  # ========================================================
	test "Can construct a recording from scratch" do
		b = @project.bookings.new
    b.date = Date.today+1
    b.start_time = "#{b.date} 12:00:00"
    b.end_time = "#{b.date} 20:00:00"
		b.facility_studio = 1
		assert b.save, "Failed to create booking"

		r = b.recordings.new
		assert_instance_of(Recording, r)
		r.group_number = 1
		r.base_filename = "fewljfkxsejf.mp3"
		r.start_time = "2013-10-10 10:10:00"
		assert r.save, "Failed to save recording"
	end

  # ========================================================
	test "Can add recording to existing booking" do
		b = Booking.where("id = 1").first
		assert_instance_of(Booking, b)

		r = b.recordings.new
		r.start_time = "2013-10-10 10:10:00"
		r.group_number = 1
		r.base_filename = "123213120-.mp3"
		assert r.save
	end

	test "Can add recording to existing project" do
		b = @project.bookings.first
		assert_instance_of(Booking, b)

		r = b.recordings.new
		r.start_time = "2013-10-10 10:10:00"
		r.group_number = 1
		r.base_filename = "123213120-.mp3"
		assert r.save
	end

	test "Can have more than one recording" do
		b = Booking.where("id = 1").first
		assert_instance_of(Booking, b)

		r = b.recordings.new
		r.start_time = "2013-10-10 10:10:00"
		r.group_number = 1
		r.base_filename = "r4123213120-.mp3"
		assert r.save

		r = b.recordings.new
		r.start_time = "2013-10-10 10:11:00"
		r.group_number = 1
		r.base_filename = "12r43213120-.mp3"
		assert r.save
	end

	test "Can set the end_time of a recording" do
		b = Booking.where("id = 1").first
		assert_instance_of(Booking, b)

		r = b.recordings.new
		r.start_time = "2013-10-10 10:12:00"
		r.group_number = 1
		r.base_filename = "awdr412321312.mp3"
		assert r.save

		r.end_time = "2013-10-10 10:13:00"
		assert r.save
	end

end
