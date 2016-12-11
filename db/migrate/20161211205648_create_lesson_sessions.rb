class CreateLessonSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_sessions do |t|
      t.integer :lesson_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
