require 'awesome_print'
require 'json'
require 'rest_client'
require 'webmock/rspec'

Dir[File.expand_path('spec/support/**/*.rb')].each { |f| require f }

def api_class_name(klass)
  full_name = klass.to_s.split('::').last
  object_name = full_name.gsub(/([A-Z])/) { |m| "_#{m}".downcase }
  object_name[1..-1]
end

def fixture_contents(klass, args=nil)
  filename = api_class_name(klass)
  filename = "#{filename}_#{args}" if args
  File.read("spec/fixtures/#{filename}.json")
end
