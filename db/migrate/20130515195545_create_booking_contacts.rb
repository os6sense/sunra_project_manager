class CreateBookingContacts < ActiveRecord::Migration
  def change
    create_table :booking_contacts do |t|
      t.references :booking_company
      t.string :contact_name
      

      t.timestamps
    end
  end
end
