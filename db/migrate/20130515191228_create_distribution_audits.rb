class CreateDistributionAudits < ActiveRecord::Migration
  def change
    create_table :distribution_audits do |t|
      t.references :format
	    t.foreign_key :format
      t.string :email_address
      t.datetime :emailed_at

      t.timestamps
    end
  end
end
