class ShiftModuleCodeArgsToArgumentsArray < ActiveRecord::Migration[5.0]
  def change
    change_column :module_codes, :arg_number, :text
    rename_column :module_codes, :arg_number, :arguments
  end
end
