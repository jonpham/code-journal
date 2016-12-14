class AddOrdinalValueToModuleCode < ActiveRecord::Migration[5.0]
  def change
    add_column :module_codes, :module_ordinal, :integer
  end
end
