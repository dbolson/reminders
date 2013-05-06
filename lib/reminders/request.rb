module Reminders
  class Request
    def initialize(access_token)
      @access_token = access_token
    end

    def get(id=nil)
      api_call(:get, url(id))
    end

    def post(params)
      api_call(:post, url, params)
    end

    def put(id, params)
      api_call(:put, url(id), params)
    end

    def delete(id)
      api_call(:delete, url(id))
    end

    private

    attr_accessor :access_token

    def url(id=nil)
      "#{base_url}#{event_list}#{id}#{auth_param}"
    end

    def base_url
      'http://localhost:3000/api/v1/'
    end

    def event_list
      'event_lists/'
    end

    def auth_param
      "?access_token=#{access_token}"
    end

    def api_call(method, url, params={})
      RestClient.send(method, url, params) do |response, request, result, &blk|
      case response.code
        when 404, 422
          response
        else
          response.return!(request, result, &blk)
        end
      end
    end
  end
end
