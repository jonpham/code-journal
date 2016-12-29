class TestCodeBuilder
  def initialize
  end
end

# MethodName
# Test_Set for ARGS
# Test_Exectation with ARGS
# TestDescription
# Method Expectation

### SHOULD CREATE ###
# describe '#module1' do 
#   it 'should return "This is me saying, hello world!"' do
#     uut = SampleLesson.new 
#     test_set1=[]
#     expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
#   end
# end
#####################

# Test Code
RSpec.describe TestCode do 
  # TEST CODE (Lesson)
  it 'should consolidate the Data from a TestCode Module to build a the RSpec Test Set from Stored Data.' do 
    uut = TestCodeBuilder.new
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_test' do 
    it 'should, given  return "This is me saying, hello world!"' do
      uut = TestCodeBuilder.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end
end
