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
#  lesson_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lesson < ApplicationRecord
  belongs_to :lesson_category
  has_many :lesson_modules

  def get_next_ordinal
    # largest_ordinal = 0
    # self.lesson_modules.each do | lesson_module | 
    #   largest_ordinal = lesson_module.lesson_ordinal if lesson_module.lesson_ordinal > largest_ordinal
    # end
    # return largest_ordinal + 1

    # Alternative
    return self.lesson_modules.max_by(&:lesson_ordinal).lesson_ordinal + 1
  end
end
