# == Schema Information
#
# Table name: test_codes
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  USE CASE :     :string 
#  Assertion_type: 
#  Expected_Return 
#  module_code_id :integer
#

class TestCode < ApplicationRecord
  belongs_to :module_code
end
