module Reminders
  class UrlBuilder
    def initialize(access_token)
      @access_token = access_token
    end

    def account_url
      url('accounts', nil)
    end

    def event_url(id=nil)
      url('events', id)
    end

    def event_list_url(id=nil)
      url('event_lists', id)
    end

    def subscriber_url(id=nil)
      url('subscribers', id)
    end

    private

    attr_accessor :access_token

    def url(resource_type, id)
      url = endpoint
      url += resource_type
      url += resource(id)
      url += access_token_param
      url
    end

    def endpoint
      'http://localhost:3000/api/v1/'
    end

    def resource(id)
      if id
        "/#{id}"
      else
        ''
      end
    end

    def access_token_param
      "?access_token=#{access_token}"
    end
  end
end
