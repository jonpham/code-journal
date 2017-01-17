# == Schema Information
#
# Table name: module_codes
#
#  id               :integer          not null, primary key
#  lesson_module_id :integer
#  method_name      :string
#  arg_number       :integer
#  return_type      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_code      :text
#  module_ordinal   :integer
#

class ModuleCode < ApplicationRecord
  serialize :arguments, Array
  belongs_to :lesson_module
  has_many :test_codes

  def solution_code
    # Get UserSnippet for Module by User ID.
    module_session = self.lesson_module.lesson.creator_module_session(self.lesson_module_id)
    if module_session
      return module_session.code_snippets.last.user_source_code 
    else
      return nil
    end
  end

  def user_code(user_id)
    # Get UserSnippet for Module by User ID.
    module_session = self.lesson_module.lesson.user_module_session(user_id,self.lesson_module_id)
    if module_session
      return module_session.code_snippets.last.user_source_code 
    else
      return nil
    end
  end
end
