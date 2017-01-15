class SampleLesson
  attr_accessor :test
  
  def initialize
    @test = Array.new
  end
  
  def run
    puts say_hello
    puts say_words("hello","world!")
    puts say_string_array(["hello","world!"])
    return 0
  end
  
  def self.build_uut
    return SampleLesson.new
  end
  
  def _say_hello
    # Return Appropriate String
  end
  
  def _say_words(word1, word2)
    # Return Appropriate String
  end
  
  def _say_string_array(input_array)
    # Return Appropriate String
  end
  
  def s_say_hello
    string = "This is me saying, hello world!"
    return string
  end
  
  def s_say_words(word1, word2)
    string = "This is me saying, #{word1} #{word2}"
    return string
  end
  
  def s_say_string_array(input_array)
    string = "This is me saying, #{input_array[0]} #{input_array[1]}"
    return string
  end
  
  def say_hello
    string = "This is me saying, hello world!"
    return string
  end
  
  def say_words(word1, word2)
    string = "This is me saying, #{word1} #{word2}"
    return string
  end
  
  def say_string_array(input_array)
    string = "This is me saying, #{input_array[0]} #{input_array[1]}"
    return string
  end
  
end