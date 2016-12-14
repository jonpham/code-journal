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
  has_many :module_sessions
  has_many :module_codes
  has_many :test_codes, through: :module_codes

  def get_next_ordinal
    return 0 if self.module_codes.count < 1
    return self.module_codes.max_by(&:module_ordinal).module_ordinal + 1
  end
end
