class CreateFileOpsAudits < ActiveRecord::Migration
  def change
    create_table :file_ops_audits do |t|
#      t.references :format
	    t.foreign_key :format
      t.datetime :encryption_started_at
      t.integer :encryption_progress
      t.datetime :encrypted_at
      t.datetime :uploaded_started_at
      t.integer :upload_progress
      t.datetime :uploaded_at
      t.datetime :copy_started_at
      t.integer :copy_progress
      t.datetime :copied_at
      t.timestamps
    end
  end
end
