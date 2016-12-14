# == Schema Information
#
# Table name: lesson_modules
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  lesson_ordinal :integer ## ADD ME!
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LessonModule < ApplicationRecord
  belongs_to :lesson
  has_many :test_codes
  has_many :module_sessions
  has_many :module_codes
end
