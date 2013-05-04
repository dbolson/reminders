module Reminders
  class EventList
    attr_accessor :status

    def initialize(response, args)
      @response = response
      @status = args[:status]
    end

    def id
      response['id']
    end

    def name
      response['name']
    end

    def created_at
      response['created_at']
    end

    def updated_at
      response['updated_at']
    end

    def errors
      response['errors']
    end

    def raw_response
      response.to_json
    end

    private

    attr_accessor :response
  end
end
