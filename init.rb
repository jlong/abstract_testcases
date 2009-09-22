if config.environment == 'test'
  require 'test/unit'
  require 'abstract_test_case_extension'
  Test::Unit::TestCase.class_eval do
    include AbstractTestCaseExtension
  end
end