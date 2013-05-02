module Reminders
  class Client
    attr_reader :access_token

    def initialize(access_token=nil)
      if access_token.nil?
        @access_token = Reminders.configuration.access_token
      else
        @access_token = access_token
      end

      if @access_token.nil?
        raise UnauthorizedError.new('Please set your access token')
      end
    end

    def event_list(id)
      request = Request.new(access_token).get(id)
      response = Response.new.parse(request)

      EventList.new(response)
    end

    def create_event_list(params)
      request = Request.new(access_token).post(params)
      response = Response.new.parse(request)

      EventList.new(response)
    end

    private

    def response(id)
      #Response.new.parse(Request.new(access_token).get(id))
    end
  end
end
