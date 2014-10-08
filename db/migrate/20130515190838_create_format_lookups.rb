class CreateFormatLookups < ActiveRecord::Migration
  def change
    create_table :format_lookups do |t|
      t.string :name
      t.string :extension

      t.timestamps
    end
  end
end
