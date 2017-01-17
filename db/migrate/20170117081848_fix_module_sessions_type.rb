class FixModuleSessionsType < ActiveRecord::Migration[5.0]
  def change
    rename_column :module_sessions, :lession_session_id, :lesson_session_id
  end
end
