class AddCreatedByToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :created_by, :integer
  end
end
