require_relative './tests/TestClasses.rb'

require 'tmpdir'
require 'JSON'
require 'YAML'
require 'rspec'

class RspecCodeRunner
  # Description ; RspecCodeRunner Class
  CODERUNNER_TMP = '/coderunner_tmp/'

  def initialize(session_id)
    time_now = Time.now
    @creation_time =  time_now.strftime("%Y%m%e_%H%M%S")
    @session_id = session_id.to_s
    @session_filename = ""
  end
  def get_tmp_dir
    # Detect OS Type. Select OS-Specific Temp Director. Check Write Permissions. Write New Temporary directory.
    return Dir.tmpdir + CODERUNNER_TMP
  end

  def build_filename
    # Build a temp_file_name from Class or Method Name (argument) and date and time. Assumption is that all files are ruby files.
    file_name = "#{@session_id}_rspec_build_#{@creation_time}.rb"
    @session_filename = file_name
    return file_name
  end

  def build_test_file_path
    @session_file_path = get_tmp_dir + build_filename
    return @session_file_path
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
  
private
  def read_file_to_s(file_path)
    return File.read(file_path) if (File::readable?(file_path) && File::file?(file_path))
  end

  def compare_to_file(string,file_path)
    test_string = read_file_to_s(file_path)
    return (string == test_string)
  end

  def write_to_json(data_object,file_path)
    File.open(file_path, "w") do |file|
      file.puts JSON.pretty_generate(data_object)
    end
  end

  def read_json_file(file_path)
    if (File.exists?(file_path)) 
      file = File.read(file_path)
      return JSON.parse(file)
    else
      puts "File Does not exist at #{file_path}"
    end
  end

  def write_to_yaml(data_object,file_path)
    File.open(file_path, "w") do |file|
      file.puts YAML.dump(data_object)
    end
  end

  def read_yaml_file(file_path)
    file = File.read(file_path)
    return YAML.load(file)
  end

  def write_string_to_file(string,file_path)
    File.open(file_path, "w") do |file|
      file.puts string
    end
  end

  def delete_tmp_files(directory)
    Dir.foreach(directory) do |file|
      # binding.pry
      # puts file.class if (file.match?(/delete.+\.rb$/))
      # File.delete(file)
    end
  end
end

# Test Code
RSpec.describe RspecCodeRunner do 
  # TEST Data : setup necessary data
  test_json_data = Testing::TestDataHandler.read_json_file(File.dirname(__FILE__)+'/tests/data/class_spec_result.json')
  test_file_path = File.dirname(__FILE__)+'/tests/data/class_spec_code.rb'


  # Class Overall Test
  it 'should take in an RSpec FilePath and return a JSON Object with the RSpec Results' do 
    # uut = RspecCodeRunner.new
    # expect(uut.execute_rspec_to_json_from_file(test_file_path)).to eq(test_json_data)
  end

  # METHOD TEST CODE 
  describe '#get_tmp_dir' do 
    it 'should return the OS detected TMP directory appended with a PreSet CodeRunner Path' do
      uut = RspecCodeRunner.new(10)
      os_tmp = Dir.tmpdir
      expect(uut.get_tmp_dir()).to eq(os_tmp + '/coderunner_tmp/')
    end
  end

  describe '#build_filename' do
    it 'test_file_name should use a parameter session id (int) to create a file name that matches the pattern <session_id>_rspec_<datetime>.rb' do
      session_id = 999999
      uut = RspecCodeRunner.new(session_id)
      file_name = uut.build_filename
      expect(file_name.match(/^\d+_rspec_build_20\d{6}_[0-2]\d{5}/)).not_to eq(nil)
    end
  end

  describe '#build_test_file_path' do
    it 'should create a valid temp file path' do
      session_id = '10'
      uut = RspecCodeRunner.new(session_id)
      app_tmp = uut.get_tmp_dir()
      file_name = uut.build_filename()
      expect(uut.build_test_file_path).to eq(app_tmp + file_name)
    end
  end

  describe '#execute_rspec_to_json_from_file' do
    it 'should do execute a rspec file that exists, and return a JSON Object with Results' do
      uut = RspecCodeRunner.new(10)
      expect(uut.execute_rspec_to_json_from_file(test_file_path)).to eq(test_json_data)
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