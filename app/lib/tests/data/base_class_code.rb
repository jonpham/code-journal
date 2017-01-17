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
  
end