class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
	    t.string :project_id, :null => false
	    t.foreign_key :project_id, :column => 'uuid'
	    t.integer :facility_studio, :null => false
      t.date :date, :null => false
      t.datetime :start_time#, :null => false
      t.datetime :end_time#, :null => false
      t.boolean :webcast, :default => false
	    t.text :availability_notes

      t.timestamps
    end
  end
end
