module Reminders
  class UrlBuilder
    def initialize(access_token)
      @access_token = access_token
    end

    def event_url(id=nil)
      "http://localhost:3000/api/v1/events/#{id}?access_token=#{access_token}"
    end

    def event_list_url(id=nil)
      "http://localhost:3000/api/v1/event_lists/#{id}?access_token=#{access_token}"
    end

    def account_url
      "http://localhost:3000/api/v1/accounts?access_token=#{access_token}"
    end

    private

    attr_accessor :access_token
  end
end
