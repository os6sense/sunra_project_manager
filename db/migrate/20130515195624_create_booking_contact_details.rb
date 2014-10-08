class CreateBookingContactDetails < ActiveRecord::Migration
  def change
    create_table :booking_contact_details do |t|
      t.references :booking_contact
      t.string :email_or_phone
      t.timestamps
    end
  end
end
