require File.expand_path(File.dirname(__FILE__) + '/../lib/app_constants')

describe "AppConstants" do

  it "should access the constants in the config file" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!

    AppConstants.public_url.should == "development.myawesomeapp.com"
    AppConstants.app_name.should == "Master of awesomeness" 
  end

  it "should return nil for non-existing environments" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.environment = "invalid"
    AppConstants.load!
    AppConstants.public_url.should be_empty

  end

  it "should process embedded code" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/template_constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!

    AppConstants.max_upload_in_bytes.should == 1048576
  end
end

#  def test_should_return_nil_for_unexisting_environments
#  end
#
#  def test_should_access_nested_constants
#    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/nested_constants.yml"
#    AppConstants.environment = "development"
#    AppConstants.load!
#
#    assert_equal "development.myawesomeapp.com", AppConstants.public_url
#    assert_equal "Master of awesomeness", AppConstants.app_name
#    assert_equal "admin@myapp.com", AppConstants.email.admin
#    assert_equal "support@myapp.com", AppConstants.email.support
#  end
#
#  def test_should_process_embedded_code
#    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/template_constants.yml"
#    AppConstants.environment = "development"
#    AppConstants.load!
#
#    assert_equal 1048576, AppConstants.max_upload_in_bytes
#  end
#end
