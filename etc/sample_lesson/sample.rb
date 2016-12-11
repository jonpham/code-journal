require 'rspec'
# require 'cj_code_runner'

# include CodeRunner
class SampleLesson
  def initialize
  end
  # User Code

  def say_hello
    string = 'This is me saying, hello world!'
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

  # Runner Code
  def module1(_args)
    return say_hello
  end

  def module2(_args)
    return say_words(_args[0], _args[1])
  end

  def module3(_args)
    return say_string_array(_args)
  end
end

RSpec.describe SampleLesson do 
  describe '#module1' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end

  describe '#module2' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set2=["hello","world!"]
      expect(uut.module2(test_set2)).to eq('This is me saying, hello world!')
    end
  end

  describe '#module3' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set3=["hello","world!"]
      expect(uut.module3(test_set3)).to eq('This is me saying, hello world!')
    end
  end
end