class AppConstants
  @@config_path = "#{Rails.root}/config/constants.yml"
  @@environment = Rails.env
  
  def self.config_path=(path)
    @@config_path = path
  end
  
  def self.environment=(environment)
    @@environment = environment
  end  
  
  def self.method_missing(method, *args)
    @@instance.constants_hash[method.to_s]
  end
  
  def self.load!
    constants_config = YAML::load(File.open(@@config_path))
    constants_hash = constants_config[@@environment] || {}
    @@instance = AppConstants.new(constants_hash)
  end  
  
  attr_reader :constants_hash
  def initialize(constants_hash)
    @constants_hash = constants_hash
  end
end
