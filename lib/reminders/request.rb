module Reminders
  class Request
    def get(id)
      url = 'http://localhost:3000/api/v1'
      url += "/event_lists/#{id}"
      url += "?access_token=#{Reminders.configuration.access_token}"

      response = RestClient.get(url)
    end
  end
end
