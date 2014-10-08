ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # If we have a problem with fixtures we dont really want a full stacktrace
  # everytime a test is loaded.
  def setup_fixtures
    begin
      super
    rescue => e
      $stdout.puts "\e[1;31m \n\tERROR while setting up fixtures\n\e[0m "
      $stdout.puts e.message
    end
  end

  setup do
    begin
    admin = Admin.find(1)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admin
    rescue ; end

  end

  # Helper, create the ids for nested resources
  def _set_ids
    project = projects(:one)
    booking = project.bookings.first
    recording = booking.recordings.first

    @sl_id = 1

    @p_id = project.id
    @b_id = booking.id
    @r_id = recording.id


    assert_not_nil @p_id
    assert_not_nil @b_id
    assert_not_nil @r_id
  end

  def _get(page, id=nil)
    _set_ids
    _set_path_hash

    if id 
      get page, id: id
    else
      get page, @path_hash
    end

    assert_response :success
  end

end
