# == Schema Information
#
# Table name: module_codes
#
#  id          :integer          not null, primary key
#  module_id   :integer
#  method_name :string
#  arg_number  :integer
#  return_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ModuleCode < ApplicationRecord
end
