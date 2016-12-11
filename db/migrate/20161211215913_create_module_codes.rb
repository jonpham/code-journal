class CreateModuleCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :module_codes do |t|
      t.integer :module_id
      t.string :method_name
      t.integer :arg_number
      t.string :return_type
      t.timestamps
    end
  end
end
