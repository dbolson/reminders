module Reminders
  module Api
    class EventList < Base
      def name
        response['name']
      end
    end
  end
end
