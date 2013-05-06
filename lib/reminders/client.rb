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

      build_event_list(request, response)
    end

    def event_lists
      request = Request.new(access_token).get
      response = Response.new.parse(request)

      response.map do |event_list|
        build_event_list(request, event_list)
      end
    end

    def create_event_list(params)
      request = Request.new(access_token).post(params)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    def update_event_list(id, params)
      request = Request.new(access_token).put(id, params)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    def delete_event_list(id)
      request = Request.new(access_token).delete(id)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    private

    def build_event_list(request, response)
      Api::EventList.new(response, status: request.code)
    end
  end
end
