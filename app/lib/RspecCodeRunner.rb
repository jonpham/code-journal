# require_relative './tests/TestClasses.rb'

require 'tmpdir'
require 'rspec'
require 'open3'
require 'fileutils'

class RspecCodeRunner
  # Description ; RspecCodeRunner Class
  CODERUNNER_TMP = '/coderunner_tmp/'

  def initialize(session_id)
    time_now = Time.now
    @creation_time =  time_now.strftime("%Y%m%e_%H%M%S")
    @session_id = session_id.to_s
    @session_filename = ""
    @results = Hash.new
  end

  def get_tmp_dir
    # Detect OS Type. Select OS-Specific Temp Director. Check Write Permissions. Write New Temporary directory.
    return Dir.tmpdir + CODERUNNER_TMP
  end

  def build_filename(ext="rb")
    # Build a temp_file_name from Class or Method Name (argument) and date and time. Assumption is that all files are ruby files.
    file_name = "#{@session_id}_rspec_build_#{@creation_time}.#{ext}"
    @session_filename = file_name
    return file_name
  end

  def build_test_file_path(ext="rb")
    @session_file_path = get_tmp_dir + build_filename(ext)
    return @session_file_path
  end

  def execute_rspec_to_json_from_file(file_path)
    return 1 unless valid_rb_file(file_path)
    json_test_args = '-fj'
    # RSpec::Core::Runner.run(file_path)
    stdout, stderr, status = Open3.capture3("rspec", json_test_args, file_path)
    full_json_string = stdout

    # Format Results
    first_index = full_json_string.index('{')
    last_index = full_json_string.rindex('}')
    string_range = last_index-first_index
    json_string = full_json_string.slice(first_index,string_range+1)

    json_result = JSON.parse(json_string)
    json_result_hash = {test_output: full_json_string, json_result: json_result}
    @results.store(:json,json_result_hash)
    return json_result_hash
  end

  def execute_rspec_to_string_from_file(file_name)
    return 1 unless valid_rb_file(file_path)
    # Setup Args
    doc_test_args = '-fd'
    # Run with Document Formatter
    stdout, stderr, status = Open3.capture3("rspec", doc_test_args, file_name)
    # Format Results
    text_results_hash = {test_output: stdout, test_errors: stderr, status: status.success?, status_code: status.exitstatus}
    @results.store(:document,text_results_hash)
    return text_results_hash
  end

  def execute_rspec_to_json_from_string(rspec_string)
    # Build Test File Path
    new_file_path = self.build_test_file_path()
    # Write To File
    write_string_to_file(rspec_string,new_file_path)
    return execute_rspec_to_json_from_file(new_file_path)
  end

  def execute_rspec_to_string_from_string(rspec_string)
    # Build Test File Path
    new_file_path = self.build_test_file_path()
    # Write To File
    write_string_to_file(rspec_string,new_file_path)
    return execute_rspec_to_string_from_file(new_file_path)
  end

  def write_results_to_json_file
    write_to_json(@results,build_test_file_path('json'))
  end

private
  def read_file_to_s(file_path)
    return File.read(file_path) if (File::readable?(file_path) && File::file?(file_path))
  end

  def compare_to_file(string,file_path)
    test_string = read_file_to_s(file_path)
    return (test_string.include?(string))
  end

  def valid_rb_file(file_path)
    return ((File.file?(file_path)) && (File.extname(file_path)=='.rb') && (compare_to_file('rspec',file_path))) 
  end

  def write_to_json(data_object,file_path)
    ensure_path_exists(file_path)
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

  def ensure_path_exists(file_path)
    dirname = File.dirname(file_path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def write_to_yaml(data_object,file_path)
    ensure_path_exists(file_path)
    File.open(file_path, "w") do |file|
      file.puts YAML.dump(data_object)
    end
  end

  def read_yaml_file(file_path)
    file = File.read(file_path)
    return YAML.load(file)
  end

  def write_string_to_file(string,file_path)
    ensure_path_exists(file_path)
    File.open(file_path, "w") do |file|
      file.puts string
    end
  end

  def delete_tmp_files
    app_tmp = get_tmp_dir()
    FileUtils.rm_rf(Dir.glob("#{app_tmp}*"))
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
      json_result = uut.execute_rspec_to_json_from_file(test_file_path)[:json_result]
      expect(json_result["summary_line"]).to eq(test_json_data["summary_line"])
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