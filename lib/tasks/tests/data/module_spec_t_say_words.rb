require 'rspec'
require 'JSON'

class TestMethod

  def say_words(word1, word2)
    string = "This is me saying, #{word1} #{word2}"
    return string
  end

  def method00(_args)
    return say_words(_args[0], _args[1])
  end

end

def build_uut
  return TestMethod.new()
end

RSpec.describe TestMethod do
  describe '#module00' do
    it 'should return "This is me saying, hello world!"' do
      uut = build_uut()
      args = JSON.parse("[\"hello\",\"world!\"]")
      expect(uut.method00(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
    end
  end
end