require File.expand_path(File.dirname(__FILE__) + '/../lib/app_constants')

describe "AppConstants" do
  it "should access the constants in the config file" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!

    AppConstants.public_url.should == "development.myawesomeapp.com"
    AppConstants.app_name.should == "Master of awesomeness"
  end

  it "should raise a RuntiemError if trying to modify constants" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.environment = "development"
    AppConstants.load!

    AppConstants.public_url.should == "development.myawesomeapp.com"

    expect { AppConstants.public_url << "trying something nasty" }.to raise_error(TypeError)
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

  it "should raise a runtime error if raise_error_on_missing is true" do
    AppConstants.config_path = "#{File.dirname(__FILE__)}/fixtures/constants.yml"
    AppConstants.raise_error_on_missing = true
    AppConstants.environment = "development"
    AppConstants.load!
    expect { AppConstants.private_url }.to raise_error(RuntimeError)
    AppConstants.public_url.should == "development.myawesomeapp.com"
    AppConstants.app_name == "Master of awesomeness"
    AppConstants.environment = "production"
    AppConstants.load!
    expect { AppConstants.private_url }.to raise_error(RuntimeError)
    AppConstants.public_url.should == "www.myawesomeapp.com"
    AppConstants.app_name == "Master of awesomeness"
    AppConstants.environment = "playpen"
    expect { AppConstants.load! }.to raise_error(RuntimeError)
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