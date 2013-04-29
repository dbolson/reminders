module Reminders
  class Request
    def get(url)
      response = RestClient.get(url)
    end
  end
end
