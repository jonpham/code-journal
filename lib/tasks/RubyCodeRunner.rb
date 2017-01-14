# require 'os'

class RubyCodeRunner 
# Description ; RubyCodeRunner Class

  def get_tmp_dir
    # Detect OS Type. Select OS-Specific Temp Director. Check Write Permissions. Write New Temporary directory.
  end

  def build_filename(object_name)
    # Build a temp_file_name from Class or Method Name (argument) and date and time. Assumption is that all files are ruby files.
  end

  def read_file_to_string(file_name,file_path)
    
  end

  def write_string_to_file(string,file_name,file_path)
  end

  def execute_rspec_to_json(file_name)
    json_result = ""+file_name
    return json_result
  end

  def execute_rspec_to_string(file_name)
    stdout_result = ""+file_name
    return stdout_result
  end

end

# Test Code
RSpec.describe RubyCodeRunner do 
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