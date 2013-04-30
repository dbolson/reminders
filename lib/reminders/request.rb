module Reminders
  class Request
    def initialize(access_token)
      @access_token = access_token
    end

    def get(id)
      response = RestClient.get(url(id))
    end

    private

    attr_accessor :access_token

    def url(id)
      url = 'http://localhost:3000/api/v1'
      url += "/event_lists/#{id}"
      url += "?access_token=#{access_token}"
    end
  end
end
