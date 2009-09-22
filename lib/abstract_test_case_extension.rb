module AbstractTestCaseExtension
  
  def self.included(base)
    unless base.respond_to? :abstract_testcases
      base.extend ClassMethods
      
      base.class_eval do
        @@abstract_testcases = []
        cattr_accessor :abstract_testcases
      end
    
      require 'test/unit/collector'
      Test::Unit::Collector.class_eval do
        def add_suite_with_abstract_classes(destination, suite)
          add_suite_without_abstract_classes(destination, suite) unless Test::Unit::TestCase.abstract_testcases.include?(suite.name)
        end
        alias_method_chain :add_suite, :abstract_classes
      end
    end
  end
  
  module ClassMethods    
    def abstract_testcase
      abstract_testcases.include?(self.name)
    end
    alias_method :abstract_testcase?, :abstract_testcase
  
    def abstract_testcase=(boolean)
      if boolean
        abstract_testcases << self.name
      else
        abstract_testcases.delete(self.name)
      end
    end
  end
  
end

