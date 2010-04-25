require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/app_constants'

class AppConstantsTest < Test::Unit::TestCase  
  def test_should_access_constants_in_the_config_file
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!
        
    assert_equal "development.myawesomeapp.com", AppConstants.public_url
    assert_equal "Master of awesomeness", AppConstants.app_name
  end
  
  def test_should_return_nil_for_unexisting_environments
    AppConstants.environment = "invalid"
    AppConstants.load!
    assert_nil AppConstants.public_url
  end
  
  def test_should_access_nested_constants
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/nested_constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!
        
    assert_equal "development.myawesomeapp.com", AppConstants.public_url
    assert_equal "Master of awesomeness", AppConstants.app_name
    assert_equal "admin@myapp.com", AppConstants.email.admin
    assert_equal "support@myapp.com", AppConstants.email.support
  end
  
  def test_should_process_embedded_code
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/template_constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!
        
    assert_equal 1048576, AppConstants.max_upload_in_bytes
  end    
end
