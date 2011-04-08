require 'yaml'
require 'erb'

class AppConstants
  @@config_path = Object.const_defined?(:Rails) ? "#{Rails.root}/config/constants.yml" : nil
  @@environment = Object.const_defined?(:Rails) ? Rails.env : 'test'
  @@raise_error_on_missing = false  # if true this will raise an error if method you seek isn't in constants_hash
  
  def self.config_path=(path)
    @@config_path = path
  end
  
  def self.environment=(environment)
    @@environment = environment
  end  
  
  def self.raise_error_on_missing=(true_false)
    @@raise_error_on_missing = true_false
  end
  
  def self.method_missing(method, *args)
    @@instance.send(method).is_a?(Hash) ? AppConstants.new(@@instance.constants_hash[method.to_s]) : @@instance.send(method)
  end

  def method_missing(method, *args)
    unless constants_hash.keys.include?(method.to_s) || @@raise_error_on_missing == false
      raise "Constant #{method.to_s} undefined in yml file. Options are: #{constants_hash.keys.join(", ")}" 
    end
    constants_hash[method.to_s].nil? ? "" : constants_hash[method.to_s].freeze 
  end
  
  def self.load!
    raise ArgumentError.new("No config file path specified. Use 'AppConstants.config_path = PATH' to set it up") if @@config_path.nil?
    constants_config = YAML::load(pre_process_constants_file)
    unless constants_config.keys.include?(@@environment) || @@raise_error_on_missing == false
      raise "Environment #{@@environment} not found in yml file.  Options are: #{constants_config.keys.join(", ")}"
    end
    constants_hash = constants_config[@@environment] || {}
    @@instance = AppConstants.new(constants_hash)
  end  
  
  def self.pre_process_constants_file
    template = File.open(@@config_path).read
    ERB.new(template).result
  end
  
  attr_reader :constants_hash
  def initialize(constants_hash)
    @constants_hash = constants_hash
  end
end
