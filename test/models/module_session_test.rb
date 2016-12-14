# == Schema Information
#
# Table name: module_sessions
#
#  id                 :integer          not null, primary key
#  lesson_module_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lession_session_id :integer
#

require 'test_helper'

class ModuleSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
