require_relative './tests/TestClasses.rb'

require 'tmpdir'
require 'rspec'

class RspecCodeRunner < Testing::TestDataHandler
  # Description ; RspecCodeRunner Class
  CODERUNNER_TMP = '/coderunner_tmp/'

  def initialize
    time_now = Time.now
    @creation_time =  time_now.strftime("%Y%m%e_%H%M%S")
  end
  def get_tmp_dir
    # Detect OS Type. Select OS-Specific Temp Director. Check Write Permissions. Write New Temporary directory.
    return Dir.tmpdir + CODERUNNER_TMP
  end

  def build_filename
    # Build a temp_file_name from Class or Method Name (argument) and date and time. Assumption is that all files are ruby files.
    file_name = 'rspec_build_' + @creation_time + '.rb'
    return file_name
  end

  def build_test_file_path(object_name)
  end

  def execute_rspec_to_json_from_file(file_name)
    json_result = ""+file_name
    return json_result
  end

  def execute_rspec_to_string_from_file(file_name)
    stdout_result = ""+file_name
    return stdout_result
  end

  def execute_rspec_to_json_from_string(rspec_string)
    json_result = ""+rspec_string
    return json_result
  end

  def execute_rspec_to_string_from_string(rspec_string)
    stdout_result = ""+rspec_string
    return stdout_result
  end

end

# Test Code
RSpec.describe RspecCodeRunner do 
  # TEST Data : setup necessary data
  test_data = {}
  test_file_path = './tests/data/class_spec_code.rb'


  # Class Overall Test
  it 'should take in an RSpec FilePath and return a JSON Object with the RSpec Results' do 
    # uut = RspecCodeRunner.new
    # expect(uut.execute_rspec_to_json_from_file(test_file_path)).to eq(test_data)
  end

  # METHOD TEST CODE 
  describe '#get_tmp_dir' do 
    it 'should return the OS detected TMP directory appended with a PreSet CodeRunner Path' do
      uut = RspecCodeRunner.new 
      os_tmp = Dir.tmpdir
      expect(uut.get_tmp_dir()).to eq(os_tmp + '/coderunner_tmp/')
    end
  end

  describe '#build_filename' do
    it 'test_file_name should match the pattern rspec_<datetime>.rb' do
      uut = RspecCodeRunner.new 
      file_name = uut.build_filename
      expect(file_name.match(/^rspec_build_20\d{6}_[0-2]\d{5}/)).not_to eq(nil)
    end
  end

  describe '#build_test_file_path' do
    it 'should do something' do
      # expect(uut.build_test_file_path()).to eq('')
    end
  end

  describe '#execute_rspec_to_json_from_file' do
    it 'should do something' do
      # expect(uut.execute_rspec_to_json_from_file()).to eq('')
    end
  end

  describe '#execute_rspec_to_string_from_file' do
    it 'should do something' do
      # expect(uut.execute_rspec_to_json_from_file()).to eq('')
    end
  end

  describe '#execute_rspec_to_json_from_string' do
    it 'should do something' do
      # expect(uut.execute_rspec_to_json_from_file()).to eq('')
    end
  end

  describe '#execute_rspec_to_string_from_string' do
    it 'should do something' do
      # expect(uut.execute_rspec_to_json_from_file()).to eq('')
    end
  end
end