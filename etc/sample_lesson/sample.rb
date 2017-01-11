require 'rspec'
# require 'cj_code_runner'

# include CodeRunner 
class SampleLesson # (module 0 )
  def initialize
  end

  # Lesson Class Runner
  def run
    puts say_hello
    puts say_words("hello","world!")
    puts say_string_array(["hello","world!"])
    return 0
  end

  # Module Code
  def _say_hello #(module 1)
    # Return Appropriate String
  end
  
  def _say_words(word1, word2) #(module 2)
    # Return Appropriate String
  end

  def _say_words(input_array=[]) #(module 3)
    # Return Appropriate String
  end

  # Solution Code

  def s_say_hello
    string = "This is me saying, hello world!"
    return string
  end

  def s_say_words(word1, word2) #(module 2)
    # Return Appropriate String
    string = "This is me saying, #{word1} #{word2}"
    return string
  end

  def s_say_words(input_array=[]) #(module 3)
    # Return Appropriate String
    string = "This is me saying, #{input_array[0]} #{input_array[1]}"
    return string
  end

  # User Code Snippets
  #```
  def say_hello
    string = "This is me saying, hello world!"
    return string
  end
  #```

  #```
  def say_words(word1, word2)
    string = "This is me saying, #{word1} #{word2}"
    return string
  end
  #```

  #```
  def say_string_array(input_array)
    string = "This is me saying, #{input_array[0]} #{input_array[1]}"
    return string
  end
  #```

  # Runner Code
  def module01(_args)
    return say_hello
  end

  def module02(_args)
    return say_words(_args[0], _args[1])
  end

  def module03(_args)
    return say_string_array(_args)
  end

  # Solution Runners
  def solution_module01(_args)
    return s_say_hello
  end

  def solution_module02s(_args)
    return s_say_words(_args[0], _args[1])
  end

  def solution_module03(_args)
    return s_say_string_array(_args[0])
  end

  def self.build_uut
    return SampleLesson.new
  end
end


# TEST CODE (Lesson)
RSpec.describe SampleLesson do 
  # TEST CODE (Lesson)
  it 'should consolidate the SampleLessons for "Hello World"' do 
    uut = SampleLesson.build_uut
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#module01' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.build_uut
      test_set1=[]
      expect(uut.module01(test_set1)).to eq('This is me saying, hello world!')
    end
  end
  
  # TEST CODE (Module)
  describe '#module02' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set2=["hello","world!"]
      expect(uut.module02(test_set2)).to eq('This is me saying, hello world!')
    end
  end
  
  # TEST CODE (Module)
  describe '#module03' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set3=[["hello","world!"]]
      expect(uut.module03(test_set3)).to eq('This is me saying, hello world!')
    end
  end
end