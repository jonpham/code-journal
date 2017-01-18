# Setup

0. Clone Repo

1. Seed Data
```
$ git clone github.com/URL
$ cd code-journal
$ bin/rails db:setup
$ bin/bundle install
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
``` 
$ bin/rails console
> test_data = LessonData.new(1,1)
> test_data.keys
> require 'awesome_print'
> ap test_data
```

# Check Ability to Execute Generated RSpec Code (Standard Format)
1. Create a RspecCodeRunner for Testing Purposes
2. Generate ClassBuilder Object 
3. Generate Class Code & RSpec as String
4. Use RspecCodeRunner to generate RSpec File and execute.
5. Inspect Both String Output and JSON Ouput
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
*There are current issues running the RSpec Execution from within the rails application, need to Turn On Class Globals **IN_RAILS_APP = true**, in RubyClassCodeBuilder & RubyMethodCodeBuilder to execute*

# Confirm that Generated RSpecs Actually work
1. Navigate to Tmp directory
2. execute Last Generated File
```
$ cd $TMPDIR/coderunner_tmp/
$ rspec -fd -c 1_rspec_build_2017011X_123456.rb
```

Should look like :
>SampleLesson
>  #method01
>   should return "This is me saying, hello world!"
>  #method02
>   should return "This is me saying, hello world!"
>  #method03
>   should return "This is me saying, hello world!"
>
>Finished in 0.00145 seconds (files took 0.0866 seconds to load)
>3 examples, 0 failures

# Check Ability to Execute Generated RSpec Code (Without Requires in Generated RSpecs)
0a. Set **IN_RAILS_APP = true** in .../app/lib/ruby_class_code_builder.rb
0b. Set **IN_RAILS_APP = true** in .../app/lib/ruby_method_code_builder.rb
1. Create a RspecCodeRunner for Testing Purposes
2. Generate ClassBuilder Object 
3. Generate Class Code & RSpec as String
4. Use RspecCodeRunner to generate RSpec File and execute.
5. Inspect Both String Output and JSON Ouput
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

