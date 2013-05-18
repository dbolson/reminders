module Reminders
  module Api
    class Account < Base
      def email
        response['email']
      end
    end
  end
end
