module Reminders
  module Api
    class EventList < Base
      def name
        response['name']
      end

      def subscriber(id)
        subscriber = response['subscribers'].detect { |s| s['id'] == id }
        subscriber_class.new(subscriber, status: @status)
      end

      def subscribers
        response['subscribers'].map { |subscriber|
          subscriber_class.new(subscriber, status: @status)
        }
      end

      private

      def subscriber_class
        Reminders::Api::Subscriber
      end
    end
  end
end
