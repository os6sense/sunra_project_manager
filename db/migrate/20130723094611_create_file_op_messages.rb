class CreateFileOpMessages < ActiveRecord::Migration
  def change
    create_table :file_op_messages do |t|
      t.foreign_key :file_ops_audits
      t.string      :message
      t.boolean     :is_error

      t.timestamps
    end
  end
end
