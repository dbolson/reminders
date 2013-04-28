require 'reminders/version'
require 'reminders/client'

module Reminders
  def foo(access_token)
    @client ||= ::Client.new(access_token)
  end

  def respond_to?(method_name, include_private=false)
    client.respond_to?(method_name, include_private) || super
  end

  private

  attr_accessor :client

  def method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end
end
