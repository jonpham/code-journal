# == Schema Information
#
# Table name: lesson_modules
#
#  id             :integer          not null, primary key
#  lesson_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lesson_ordinal :integer
#  description    :text
#

class LessonModule < ApplicationRecord
  belongs_to :lesson
  has_many :test_codes
  has_many :module_sessions
  has_many :module_codes
end
