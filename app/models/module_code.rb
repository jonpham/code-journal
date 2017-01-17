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
    creator_id = self.lesson_module.lesson.created_by
    puts "creator_id == #{creator_id}"
    # Get UserSnippet for Module by User ID.
    lesson_session = LessonSession.where("lesson_id = ? AND user_id = ?",self.lesson_module.lesson.id, self.lesson_module.lesson.created_by)[0]
    module_session = ModuleSession.where("lession_session_id = ? AND lesson_module_id = ?",lesson_session.id,self.lesson_module_id)[0]
    module_session.code_snippets
  end
end
