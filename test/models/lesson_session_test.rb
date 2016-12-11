# == Schema Information
#
# Table name: lesson_sessions
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LessonSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
