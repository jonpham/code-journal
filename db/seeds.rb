# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!({:email => "me@cj.com", :password => "asdf", :password_confirmation => "asdf" })

# Read Text from File / JSON ?
LessonCategory.create({category_name:'Development', 
    category_description:'Lessons that help to make this App.'})

## Sample Problem

# Lesson Code 

# Test Code

# Lesson
    # t.string   "name"
    # t.text     "concept"
    # t.text     "purpose"
    # t.text     "description"
    # t.text     "example"
    # t.integer  "lesson_code_id"
    # t.integer  "test_code_id"
    # t.integer  "lesson_category_id"
Lesson.create(
  {
    name:'Sample Lesson',
    concept:'Concept',
    purpose:'Purpose: Hello World!',
    description: 'Description',
    example: 'Example',
    lesson_code_id: 1,
    test_code_id: 1,
    lesson_category_id: LessonCategory.find_by(category_name:'Development').id
  }
)



