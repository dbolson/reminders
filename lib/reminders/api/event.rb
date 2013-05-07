module Reminders
  module Api
    class Event
      attr_accessor :status

      def initialize(response, args)
        @response = response
        @status = args[:status]
      end

      def id
        response['id']
      end

      def event_list
        event_list_class.new(response['event_list'], status: @status)
      end

      def name
        response['name']
      end

      def description
        response['description']
      end

      def due_at
        response['due_at']
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

      def event_list_class
        Reminders::Api::EventList
      end
    end
  end
end
