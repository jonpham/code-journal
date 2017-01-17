require_relative './testing/test_data_handler.rb'
require_relative '../app/lib/rspec_code_runner.rb'

# Test Code
RSpec.describe RspecCodeRunner do 
  # TEST Data : setup necessary data
  test_json_data = Testing::TestDataHandler.read_json_file(File.dirname(__FILE__)+'/testing/data/class_spec_result.json')
  test_file_path = File.dirname(__FILE__)+'/testing/data/class_spec_code.rb'

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