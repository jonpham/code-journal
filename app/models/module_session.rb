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

class ModuleSession < ApplicationRecord
  belongs_to :lesson_module
  belongs_to :user
end
