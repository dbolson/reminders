module Reminders
  class Client
    def initialize(access_token=nil)
      @access_token = access_token
    end

    def event_lists
      url = "http://localhost:3000/api/v1/event_lists?access_token=#{access_token}"
      response = RestClient.get(url)
      JSON.parse(response)
    end

    private

    attr_reader :access_token
  end
end
