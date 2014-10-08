class CreateStudioLookups < ActiveRecord::Migration
  def change
    create_table :studio_lookups do |t|
	    t.string :facility_name
      t.string :studio_name
      t.string :mdns_localname
      t.string :ip_fallback
      t.string :phone
      t.boolean :active

      t.timestamps
    end
  end
end
