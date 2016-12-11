# == Schema Information
#
# Table name: module_sessions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  lesson_module_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class ModuleSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
