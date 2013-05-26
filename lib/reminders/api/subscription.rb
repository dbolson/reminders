module Reminders
  module Api
    class Subscription < Base
      def event_list
        event_list_class.new(response['event_list'], status: @status)
      end

      def subscriber
        subscriber_class.new(response['subscriber'], status: @status)
      end

      private

      def event_list_class
        Reminders::Api::EventList
      end

      def subscriber_class
        Reminders::Api::Subscriber
      end
    end
  end
end
