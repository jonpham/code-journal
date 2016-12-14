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

class ModuleSession < ApplicationRecord
  belongs_to :lesson_module
  belongs_to :user
end
