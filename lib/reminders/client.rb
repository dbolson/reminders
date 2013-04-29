module Reminders
  class Client
    attr_reader :access_token

    def initialize(access_token=nil)
      if access_token.nil?
        @access_token = Reminders.configuration.access_token
      else
        @access_token = access_token
      end
    end

    def event_list(id)
      if access_token.nil?
        raise UnauthorizedError.new('Please set your access token')
      end

      EventList.new(response(id))
    end

    private

    def response(url)
      Response.new.parse(Request.new.get(url))
    end
  end
end
