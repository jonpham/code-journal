class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :concept
      t.text :purpose
      t.text :description
      t.text :example
      t.integer :lesson_code_id
      t.integer :test_code_id
      t.integer :lesson_category_id

      t.timestamps
    end
  end
end
