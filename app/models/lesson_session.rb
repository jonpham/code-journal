# == Schema Information
#
# Table name: lesson_sessions
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LessonSession < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_many :module_sessions

  def get_module_session(lesson_module_id)
    return ModuleSession.where("lesson_session_id = ? AND lesson_module_id = ?",self.id,lesson_module_id).limit(1)[0]
  end

  def get_progress
  end
end
