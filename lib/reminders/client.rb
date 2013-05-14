module Reminders
  class UrlBuilder
    def initialize(access_token)
      @access_token = access_token
    end

    def event_url(id=nil)
      "http://localhost:3000/api/v1/events/#{id}?access_token=#{access_token}"
    end

    def event_list_url(id=nil)
      "http://localhost:3000/api/v1/event_lists/#{id}?access_token=#{access_token}"
    end

    private

    attr_accessor :access_token
  end

  class Client
    attr_reader :access_token

    def initialize(access_token=nil)
      if access_token.nil?
        @access_token = Reminders.configuration.access_token
      else
        @access_token = access_token
      end

      if @access_token.nil?
        raise UnauthorizedError.new('Please set your access token')
      end
    end

    def event(id)
      url = UrlBuilder.new(access_token).event_url(id)
      request = Request.get(url)
      response = Response.new.parse(request)

      build_event(request, response)
    end

    def events
      url = UrlBuilder.new(access_token).event_url
      request = Request.get(url)
      response = Response.new.parse(request)

      response.map do |event_list|
        build_event(request, event_list)
      end
    end

    def create_event(params)
      url = UrlBuilder.new(access_token).event_url
      request = Request.post(url, params)
      response = Response.new.parse(request)

      build_event(request, response)
    end

    def update_event(id, params)
      url = UrlBuilder.new(access_token).event_url(id)
      request = Request.put(url, params)
      response = Response.new.parse(request)

      build_event(request, response)
    end

    def delete_event(id)
      url = UrlBuilder.new(access_token).event_url(id)
      request = Request.delete(url)
      response = Response.new.parse(request)

      build_event(request, response)
    end

    def event_list(id)
      url = UrlBuilder.new(access_token).event_list_url(id)
      request = Request.get(url)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    def event_lists
      url = UrlBuilder.new(access_token).event_list_url
      request = Request.get(url)
      response = Response.new.parse(request)

      response.map do |event_list|
        build_event_list(request, event_list)
      end
    end

    def create_event_list(params)
      url = UrlBuilder.new(access_token).event_list_url
      request = Request.post(url, params)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    def update_event_list(id, params)
      url = UrlBuilder.new(access_token).event_list_url(id)
      request = Request.put(url, params)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    def delete_event_list(id)
      url = UrlBuilder.new(access_token).event_list_url(id)
      request = Request.delete(url)
      response = Response.new.parse(request)

      build_event_list(request, response)
    end

    private

    def build_event_list(request, response)
      Api::EventList.new(response, status: request.code)
    end

    def build_event(request, response)
      Api::Event.new(response, status: request.code)
    end
  end
end
