class ShiftModuleNeedsAndRemoveUnnecessaryUserIds < ActiveRecord::Migration[5.0]
  def change
    drop_table :lesson_code
    add_column :lesson_modules, :lesson_ordinal, :integer
    add_column :lesson_modules, :description, :text
    remove_column :module_sessions, :user_id
    add_column :module_sessions, :lession_session_id, :integer
    remove_column :lessons, :lesson_code_id
    remove_column :lessons, :test_code_id
    add_column :module_codes, :source_code, :text
    remove_column :test_codes, :lesson_module_id
    add_column :test_codes, :module_code_id, :integer
  end
end
