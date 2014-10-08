class CreateClientLogins < ActiveRecord::Migration
  def change
    create_table :client_logins do |t|
	    t.string :project_id, :null => false
	    t.foreign_key :project_id, :column => 'uuid'
	    t.string :login_email
	    t.string :password_digest
	    t.string :recoverable
	    t.string :key_name
      t.timestamps
    end
  end
end
