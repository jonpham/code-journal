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

require 'test_helper'

class CodeSnippetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
