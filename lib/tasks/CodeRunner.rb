class CodeRunner 
end

# Test Code
RSpec.describe CodeRunner do 
  # TEST CODE (Lesson)
  it 'should consolidate the SampleLessons for "Hello World"' do 
    uut = SampleLesson.new
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#module1' do 
    it 'should return "This is me saying, hello world!"' do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end
end