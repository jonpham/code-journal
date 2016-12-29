class ClassCode
  attr_accessor :method_set

  def initialize
    @module_set = []
  end

  def add_method
  end

end

# Test Code
RSpec.describe ClassCode do 
  # TEST CODE (Lesson)
  it 'should consolidate "module_codes" passed in to create single class code snippets and executable rspec.' do 
    uut = SampleLesson.new
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_code' do 
    it "should loop through each method in the 'method_set' and build its code into text string, to be used to write to a file."  do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end

  describe '#build_test' do 
    it "should loop through each method in the 'method_set' and build its test code." do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end

  describe '#build_spec' do
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end

  # TEST CODE (Module)
  describe '#build_markup' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end
end