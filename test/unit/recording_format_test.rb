require 'test_helper'

class RecordingFormatTest < ActiveSupport::TestCase

  #  Helpers
  def _get_upload(studio_id = 2)
     RecordingFormat.to_upload(studio_id)
  end 
  def _get_copy(studio_id = 2)
     RecordingFormat.to_copy(studio_id)
  end 
  def _get_encrypt(studio_id = 2)
     RecordingFormat.to_encrypt(studio_id)
  end 

  # Tests
  test "WILL NOT create an empty recording format" do
	  p = RecordingFormat.new
    assert !p.save
  end

  test "provides a to_upload meth0d" do
    assert RecordingFormat.singleton_methods.include?(:to_upload) == true
  end 

  test "to_upload returns [] if no records are found" do
    assert _get_upload(-1) == []
  end

  test "to_copy returns [] if no records are found" do
    assert _get_copy(-1) == []
  end

  test "to_encrypt returns [] if no records are found" do
    assert _get_encrypt(-1) == []
  end

  # The below tests are all based on the data supplied via the 
  # fixtures. 
  test "to_upload#size = 2 on success" do
    assert _get_upload.size == 2
  end

  test "to_upload#id returns 1 on success" do
    assert _get_upload[0][:id] == 1
  end

  test "to+upload#recording_id returns 1 on success" do
    assert _get_upload[0][:recording_id] == 1
  end

  test "to_upload#format returns 2 on success" do
    assert _get_upload[0][:format] == 2
  end

  test "to_upload#directory returns /blah/lah/projuuid/1 on success" do
    assert _get_upload[0][:directory] == "/blah/lah/projuuid/1"
  end

  test "to_upload#filesize == on success" do
    assert _get_upload[0][:filesize] == 0
  end

  test "to_upload#upload returns true on success" do 
    assert _get_upload[0][:upload] == true
  end

  # Testing to_load should be sufficient to ensure the fields are present
  # and return the expected values. We also want to ensure that the 
  # encrypt and copy methods exist and are true.
  
  test "to_copy#copy returns true on success" do 
    assert _get_copy[0][:copy] == true
  end

  test "to_encrypt#encrypt returns true on success" do 
    assert _get_encrypt[0][:encrypt] == true
  end

  test "to_upload#booking_id is > 0" do
    assert _get_upload[0][:booking_id] > 0
  end

  test "to_upload#project_id is valid and correct" do
    assert _get_upload[0][:project_id] == "poewripewojrjo34jp32j4p324j342342klggre"
  end
end
