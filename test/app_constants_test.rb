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
end
