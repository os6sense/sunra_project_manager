class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
	    t.integer :booking_id, :null => false
	    t.foreign_key :booking_id, :null => false
      t.datetime :start_time, :null => false
      t.datetime :end_time
      t.integer :group_number, :null => false
      t.string :base_filename, :null => false

      t.timestamps
    end
  end
end
