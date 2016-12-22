

class MethodCode
  # include MardownConverter
  # include SourceBuilder
  
  def initialize(input_args)
    @method_name = input_args[:method_name]
    @num_args = input_args[:num_args]
    @return_type = input_args[:return_type]
    @source_code = input_args[:source_code]
  end

  def build_code
    method_string = ''
    return method_string
  end
end


# Test Code
RSpec.describe MethodCode do 

  # TEST CODE (Lesson)
  it 'should consolidate "module_arguemnts" passed in to create single module code snippet.' do 
    uut = SampleLesson.new
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_code' do 
    it 'should be able to recognize when there are no arguments expected"' do
      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end

  # TEST CODE (Module)
  describe '#build_markup' do 
    it 'should be able to return string that will be recognized as MarkDown' do
      # Setup Expected Data
      

      uut = SampleLesson.new 
      test_set1=[]
      expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
    end
  end
end
