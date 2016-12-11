class CreateModuleSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :module_sessions do |t|
      t.integer :user_id
      t.integer :module_id
      
      t.timestamps
    end
  end
end
