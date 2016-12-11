class CreateCodeSnippets < ActiveRecord::Migration[5.0]
  def change
    create_table :code_snippets do |t|
      t.text :user_source_code
      t.integer :module_session_id
      t.timestamps
    end
  end
end
