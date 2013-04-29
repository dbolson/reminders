module Reminders
  class Response
    def parse(response)
      JSON.parse(response)
    end
  end
end
