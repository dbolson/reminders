module Reminders
  class Client
    def initialize(access_token=nil)
      @access_token = access_token
    end

    def event_list(id)
      EventList.new(response(url(id)))
    end

    private

    attr_reader :access_token

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
