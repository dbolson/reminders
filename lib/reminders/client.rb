module Reminders
  class Error < StandardError; end
  class UnauthorizedError < Error; end

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

      EventList.new(response(url(id)))
    end

    private

    def url(id)
      "#{base_url}event_lists/#{id}?#{parameters}"
    end

    def base_url
      'http://localhost:3000/api/v1/'
    end

    def parameters
      "access_token=#{access_token}"
    end

    def response(url)
      Response.new.parse(Request.new.get(url))
    end
  end
end
