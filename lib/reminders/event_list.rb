module Reminders
  class EventList
    attr_accessor :id

    def initialize(response)
      @response = response
    end

    def id
      response['event_list']['id']
    end

    def name
      response['event_list']['name']
    end

    def created_at
      response['event_list']['created_at']
    end

    def updated_at
      response['event_list']['updated_at']
    end

    def status_code
      response['status']
    end

    private

    attr_accessor :response
  end
end
