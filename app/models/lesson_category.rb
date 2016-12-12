# == Schema Information
#
# Table name: lesson_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LessonCategory < ApplicationRecord
  has_many :lessons
end
