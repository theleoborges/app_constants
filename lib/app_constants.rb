require 'yaml'
require 'erb'

class AppConstants
  @@config_path = Object.const_defined?(:Rails) ? "#{Rails.root}/config/constants.yml" : nil
  @@environment = Object.const_defined?(:Rails) ? Rails.env : 'test'
  @@raise_error_on_missing = false  # if true this will raise an error if method you seek isn't in constants_hash

  def self.config_path
    @@config_path
  end

  def self.config_path=(path)
    @@config_path = path
  end

  def self.environment
    @@environment
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
    fail_if_constant_missing(method.to_s)
    if constants_hash[method.to_s].nil?
      ""
    elsif constants_hash[method.to_s].is_a?(Hash)
      AppConstants.new(constants_hash[method.to_s])
    else
      constants_hash[method.to_s].freeze
    end
  end

  def fail_if_constant_missing(constant)
    unless constants_hash.keys.include?(constant) || @@raise_error_on_missing == false
      raise "Constant #{constant} undefined in yml file. Options are: #{constants_hash.keys.join(", ")}"
    end
  end
  private :fail_if_constant_missing

  def self.load!
    raise ArgumentError.new("No config file path specified. Use 'AppConstants.config_path = PATH' to set it up") if @@config_path.nil?
    constants_config = YAML::load(pre_process_constants_file)
    fail_if_environment_missing(@@environment, constants_config)
    constants_hash = constants_config[@@environment] || {}
    @@instance = AppConstants.new(constants_hash)
  end

  def self.fail_if_environment_missing(env, config)
    unless config.keys.include?(env) || @@raise_error_on_missing == false
      raise "Environment #{env} not found in yml file.  Options are: #{config.keys.join(", ")}"
    end
  end
  private_class_method :fail_if_environment_missing
  
  def self.pre_process_constants_file
    template = File.open(@@config_path).read
    ERB.new(template).result
  end

  def self.respond_to_missing?(method, private = false)
    @@instance.constants_hash.keys.include?(method.to_s)
  end
  
  attr_reader :constants_hash
  def initialize(constants_hash)
    @constants_hash = constants_hash
  end
end
