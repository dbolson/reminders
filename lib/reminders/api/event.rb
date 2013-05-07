module Reminders
  module Api
    class Event < Base
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

      private

      def event_list_class
        Reminders::Api::EventList
      end
    end
  end
end
