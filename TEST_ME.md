# Setup

0. Clone Repo

1. Seed Data
```
$ git clone github.com/URL
$ cd code-journal
$ bin/rails db:setup
```

# Test CodeBuilder/Runners
1. Run Rspec on Codebuilder specs
```
$ cd ./spec
$ rspec -fd -c rspec_code_runner_spec.rb
$ rspec -fd -c ruby_class_code_bulder_spec.rb
$ rspec -fd -c ruby_method_code_bulder_spec.rb
```

# Check Ability to Aggregate lessons into Single Data Object
1. Open Rails Console
2. Create new LessonData object. 
3. Create a RspecCodeRunner for Testing Purposes
4. Generate ClassBuilder Object 
5. Generate Class Code & RSpec as String
6. Use RspecCodeRunner to generate RSpec File and execute.
7. Inspect Both String Output and JSON Ouput
``` 
$ bin/rails console
> test_data = LessonData.new(1,1)
> test_data_session_id = test_data.session_data[:user_session].id
> rspec_runner = RspecCodeRunner.new(test_data_session_id)
> class_builder = test_data.build_lesson
> test_spec = class_builder.build_spec
> string_result = rspec_runner.execute_rspec_to_string_from_string(test_spec)
> json_result = rspec_runner.execute_rspec_to_json_from_string(test_spec)
```
*There are current issues running the RSpec Execution from within the rails application, *