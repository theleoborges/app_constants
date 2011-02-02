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

  describe "#load!" do

    before(:each) do
      AppConstants.config_path = nil
    end
    it "should raise an ArgumentError if path is null" do
      expect { AppConstants.load! }.to raise_error(ArgumentError)
    end
  end
end