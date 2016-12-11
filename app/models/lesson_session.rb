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
end
