class CreateRecordingFormats < ActiveRecord::Migration
  def change
    create_table :recording_formats do |t|
      t.references  :recording
	    t.foreign_key :recording

      t.integer      :format, :null => false
      t.string      :directory, :null => false
      t.string      :remote_directory
      t.integer     :filesize, :default => 0
      t.datetime    :start_time, :null => false
      t.datetime    :end_time
      t.string      :sha1hash
      t.boolean     :upload, :default => false
      t.boolean     :copy, :default => false
      t.boolean     :encrypt, :default => false
      t.boolean     :encrypted, :default => false
      t.boolean     :fixed_moov_atom, :default => false

      t.timestamps
    end
  end
end
