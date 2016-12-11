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

require 'test_helper'

class LessonCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
