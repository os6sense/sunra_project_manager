class CreateBookingCompanies < ActiveRecord::Migration
  def change
    create_table :booking_companies do |t|
      t.string :company_name

      t.timestamps
    end
  end
end
