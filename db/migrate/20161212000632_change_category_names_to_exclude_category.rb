class ChangeCategoryNamesToExcludeCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :lesson_categories, :category_name, :name
    rename_column :lesson_categories, :category_description, :description
  end
end
