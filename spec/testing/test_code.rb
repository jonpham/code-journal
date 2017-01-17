module Testing
  class TestCode
    attr_accessor :assertion_type, :expected_return, :expected_test_data, :test_description
    
    def initialize(input_data)
      @assertion_type = input_data[:assertion_type]
      @expected_return = input_data[:expected_return]
      @expected_test_data = input_data[:expected_test_data]
      @test_description = input_data[:test_description]
    end
  end
end