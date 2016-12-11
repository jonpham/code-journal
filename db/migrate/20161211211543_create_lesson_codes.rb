class CreateLessonCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_codes do |t|
      t.integer :lesson_id
      t.text :source_code
      t.timestamps
    end
  end
end
