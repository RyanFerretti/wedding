# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem "faraday"
  config.gem "faraday_middleware"
  config.gem "cancan", :version => '1.4.0'
  config.gem "rack-openid", :lib => 'rack', :version => '1.2.0'
  config.gem "aws-s3", :lib => "aws/s3", :version => '0.6.2'
  config.time_zone = 'UTC'
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => "%B %d, %Y")
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => "%B %d, %Y")