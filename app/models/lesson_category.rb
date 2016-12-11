# == Schema Information
#
# Table name: lesson_categories
#
#  id                   :integer          not null, primary key
#  category_name        :string
#  category_description :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class LessonCategory < ApplicationRecord
  has_many :lessons
end
