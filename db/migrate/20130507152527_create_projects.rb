class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, :id => false, :primary_key => :uuid do |t|
      t.string :uuid, :null => false
      t.string :client_name, :null => false
      t.string :project_name, :null => false
      t.timestamps
    end
  end
end
