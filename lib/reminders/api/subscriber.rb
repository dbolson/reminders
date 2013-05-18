module Reminders
  module Api
    class Subscriber < Base
      def phone_number
        response['phone_number']
      end
    end
  end
end
