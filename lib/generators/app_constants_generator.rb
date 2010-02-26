class AppConstantsGenerator < Rails::Generators::Base
  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end  
  
  def copy_config_files
    copy_file('constants.yml', 'config/constants.yml')
    copy_file('load_app_constants.rb', 'config/initializers/load_app_constants.rb')
  end  
end
