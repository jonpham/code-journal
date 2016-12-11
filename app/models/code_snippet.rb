# == Schema Information
#
# Table name: code_snippets
#
#  id                :integer          not null, primary key
#  user_source_code  :text
#  module_session_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class CodeSnippet < ApplicationRecord
  belongs_to :module_session
end
