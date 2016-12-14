# == Schema Information
#
# Table name: test_codes
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  module_code_id :integer
#

class TestCode < ApplicationRecord
  belongs_to :lesson_module
end
