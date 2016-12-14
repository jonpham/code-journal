# == Schema Information
#
# Table name: lesson_codes
#
#  id          :integer          not null, primary key
#  lesson_id   :integer
#  source_code :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
#### UNNECESSARY!!! ####
class LessonCode < ApplicationRecord
end
