module Reminders
  class Client
    def initialize(access_token=nil)
      @access_token = access_token
    end

    def get(url)
      response = RestClient.get(url)
      JSON.parse(response)
    end

    #def event_lists
      #url = "http://localhost:3000/api/v1/event_lists?access_token=#{access_token}"
      #response = RestClient.get(url)
      #JSON.parse(response)
    #end

    private

    attr_reader :access_token
  end

  class EventList
    attr_accessor :id

    def initialize(id)
      @id = id
    end

    def name
      url = "http://localhost:3000/api/v1/event_lists/#{id}?access_token=access_token"
      response = Client.new('access token').get(url)
      response['event_list']['name']
    end

    private
  end
end
