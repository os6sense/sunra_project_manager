class AddWebcastToBooking < ActiveRecord::Migration
  def change
	remove_column :bookings, :webcast
	add_column :bookings, :webcast, :boolean
  end
end
