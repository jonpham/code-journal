require 'rspec'
require 'cj_code_runner'

# include CodeRunner
class SampleLesson
  def initialize
  end
  # User Code

  def say_hello
    puts 'hello world!'
  end

  def say_words(word1, word2)
    puts "This is me saying, #{word1} and #{word2}"
  end

  # Runner Code
  def module1
    say_hello
  end

  def module2(args)
    say_words(args[0], args[1])
  end
end

RSpec.describe SampleLesson do 
  describe '#module1' do 
    it 'should return the sum of all items in the array' do
      uut = SampleLesson.new 
      expect(uut.module1(test_set1)).to eq(15)
    end
  end
end