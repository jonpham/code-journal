# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  name               :string
#  concept            :text
#  purpose            :text
#  description        :text
#  example            :text
#  lesson_code_id     :integer #REPLACE WITH MODULE 0 CODE?
#  test_code_id       :integer #REPLACE WITH MODULE 0 CODE -> Test Code?
#  lesson_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lesson < ApplicationRecord
  belongs_to :lesson_category
  has_many :lesson_modules
end
