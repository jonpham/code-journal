class CreateLessonCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_categories do |t|

      t.string :category_name 
      t.text :category_description
      
      t.timestamps
    end
  end
end
