load 'TestData.rb'
lesson_data = Testing::TestDataHandler.read_yaml_file('./data/class_code_builder.yml')
lesson_data[:class_methods]["initialize"][:builder].arguments
lesson_data[:class_methods]["initialize"][:builder].build_code