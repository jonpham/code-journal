class CreateLessonModules < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_modules do |t|
      t.integer :lesson_id
      
      t.timestamps
    end
  end
end
