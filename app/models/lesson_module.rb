# == Schema Information
#
# Table name: lesson_modules
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LessonModule < ApplicationRecord
  belongs_to :lesson
end
