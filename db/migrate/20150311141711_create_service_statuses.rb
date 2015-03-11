class CreateServiceStatuses < ActiveRecord::Migration
  def change
    create_table :service_statuses do |t|

      t.timestamps
    end
  end
end
