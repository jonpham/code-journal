class AdjustModuleIdColums < ActiveRecord::Migration[5.0]
  def change
    rename_column :test_codes, :module_id, :lesson_module_id
    rename_column :module_codes, :module_id, :lesson_module_id
    rename_column :module_sessions, :module_id, :lesson_module_id
  end
end
