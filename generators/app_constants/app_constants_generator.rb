class AppConstantsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory('config')
      m.file('constants.yml', 'config/constants.yml')
      m.directory('config/initializers')
      m.file('load_app_constants.rb', 'config/initializers/load_app_constants.rb')
    end
  end
end
