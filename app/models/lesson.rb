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
#  lesson_code_id     :integer
#  test_code_id       :integer
#  lesson_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lesson < ApplicationRecord
end
