# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Drop All Data #
CodeSnippet.destroy_all
ModuleSession.destroy_all
LessonSession.destroy_all
User.destroy_all

TestCode.destroy_all
ModuleCode.destroy_all
LessonModule.destroy_all
Lesson.destroy_all
LessonCategory.destroy_all
#################
DEFAULT_PASSWORD='asdf1234'
User.create!({:email => "me@cj.com", :password => "qwer123", :password_confirmation => "qwer123", :admin => true })
User.create!({:email => "user@cj.com", :password => DEFAULT_PASSWORD, :password_confirmation => DEFAULT_PASSWORD, :admin => false })

admin_user = User.find_by(email: "me@cj.com")

# Read Text from File / JSON ?
LessonCategory.create({name:'Development', 
  description:'Lessons that help to make this App.'})

## Sample Problem

# Lesson
  # t.string   "name"
  # t.text     "concept"
  # t.text     "purpose"
  # t.text     "description"
  # t.text     "example"
  # t.integer  "lesson_code_id"
  # t.integer  "test_code_id"
  # t.integer  "lesson_category_id"
sample_lesson = Lesson.new(
  {
    name:'Sample Lesson',
    concept:'Concept',
    purpose:'Purpose: Hello World!',
    description: 'Description',
    example: 'Example',
    lesson_category_id: LessonCategory.find_by(name:'Development').id,
    created_by: admin_user.id
  }
)

# Represents the Main Class Module (Module 0)
if sample_lesson.save
  sample_module = LessonModule.create(
    {
      lesson_id: sample_lesson.id,
      lesson_ordinal: 0,
      description: "Lesson #{sample_lesson.name}: Module 0 represents the Main Lesson Page"
    }
  )
end

# Lesson Class Code (ModuleCode)
#  id               :integer          not null, primary key
#  lesson_module_id :integer
#  method_name      :string
#  arg_number       :integer
#  return_type      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_code      :text
#  module_ordinal   :integer
# 
class_method_hash = {
  lesson_module_id: sample_module.id,
  method_name: "SampleLesson",
  arguments: ['test'],
  return_type: 'void',
  source_code: 'attr_accessor :test',
  module_ordinal: 0
}
ModuleCode.create(class_method_hash)
# Test Code



