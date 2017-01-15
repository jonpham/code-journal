class AddCodeModelChangesForTestData < ActiveRecord::Migration[5.0]
  def change
    add_column :test_codes, :assertion_type, :string
    add_column :test_codes, :expected_return, :text
    add_column :test_codes, :expected_test_data, :text
    add_column :test_codes, :description, :text
  end
end
