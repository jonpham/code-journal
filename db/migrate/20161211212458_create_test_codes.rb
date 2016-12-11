class CreateTestCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :test_codes do |t|
      t.integer :module_id
      t.timestamps
    end
  end
end
