require 'rspec'
require 'JSON'

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
  
  def method01(_args)
    return say_hello
  end
  
  def method02(_args)
    return say_words(_args[0], _args[1])
  end
  
  def method03(_args)
    return say_string_array(_args[0])
  end
  
  def solution_method01(_args)
    return s_say_hello
  end
  
  def solution_method02(_args)
    return s_say_words(_args[0], _args[1])
  end
  
  def solution_method03(_args)
    return s_say_string_array(_args[0])
  end
  
end

def build_uut
  return SampleLesson.new()
end

RSpec.describe SampleLesson do
  describe '#method01' do
    it 'should return "This is me saying, hello world!"' do
      uut = build_uut()
      args = JSON.parse("null")
      expect(uut.method01(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
    end
  end

  describe '#method02' do
    it 'should return "This is me saying, hello world!"' do
      uut = build_uut()
      args = JSON.parse("[\"hello\",\"world!\"]")
      expect(uut.method02(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
    end
  end

  describe '#method03' do
    it 'should return "This is me saying, hello world!"' do
      uut = build_uut()
      args = JSON.parse("[[\"hello\",\"world!\"]]")
      binding.pry
      expect(uut.method03(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
    end
  end
end
