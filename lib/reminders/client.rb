module Reminders
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

    def account
      call_account(:get) do |request, response|
        Api::Account.new(response, status: request.code)
      end
    end

    def update_account(params)
      call_account(:put, 'account' => params) do |request, response|
        build_account(request, response)
      end
    end

    def event(id)
      call_event(:get, id) do |request, response|
        build_event(request, response)
      end
    end

    def events
      call_event(:get) do |request, response|
        response.map { |event| build_event(request, event) }
      end
    end

    def create_event(params)
      call_event(:post, nil, 'event' => params) do |request, response|
        build_event(request, response)
      end
    end

    def update_event(id, params)
      call_event(:put, id, 'event' => params) do |request, response|
        build_event(request, response)
      end
    end

    def delete_event(id)
      call_event(:delete, id) do |request, response|
        build_event(request, response)
      end
    end

    def event_list(id)
      call_event_list(:get, id) do |request, response|
        build_event_list(request, response)
      end
    end

    def event_lists
      call_event_list(:get) do |request, response|
        response.map { |event_list| build_event_list(request, event_list) }
      end
    end

    def create_event_list(params)
      call_event_list(:post, nil, 'event_list' => params) do |request, response|
        build_event_list(request, response)
      end
    end

    def update_event_list(id, params)
      call_event_list(:put, id, 'event_list' => params) do |request, response|
        build_event_list(request, response)
      end
    end

    def delete_event_list(id)
      call_event_list(:delete, id) do |request, response|
        build_event_list(request, response)
      end
    end

    private

    def call_account(method, params={}, &blk)
      url = UrlBuilder.new(access_token).account_url
      request = Request.send(method, url, params)
      response = Response.new.parse(request)
      blk.call(request, response)
    end

    def call_event(method, id=nil, params={}, &blk)
      url = UrlBuilder.new(access_token).event_url(id)
      request = Request.send(method, url, params)
      response = Response.new.parse(request)
      blk.call(request, response)
    end

    def call_event_list(method, id=nil, params={}, &blk)
      url = UrlBuilder.new(access_token).event_list_url(id)
      request = Request.send(method, url, params)
      response = Response.new.parse(request)
      blk.call(request, response)
    end

    def build_account(request, response)
      Api::Account.new(response, status: request.code)
    end

    def build_event(request, response)
      Api::Event.new(response, status: request.code)
    end

    def build_event_list(request, response)
      Api::EventList.new(response, status: request.code)
    end
  end
end
