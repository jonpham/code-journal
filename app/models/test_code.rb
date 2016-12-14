# == Schema Information
#
# Table name: test_codes
#
#  id               :integer          not null, primary key
#  lesson_module_id :integer ### CHANGE TO
#  module_code_id :integer 
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TestCode < ApplicationRecord
  belongs_to :lesson_module
end
