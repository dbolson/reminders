module Reminders
  class Request
    def initialize(url)
      @url = url
    end

    def self.get(url, args={})
      new(url).send(:api_call, :get)
    end

    def self.post(url, params)
      new(url).send(:api_call, :post, params)
    end

    def self.put(url, params)
      new(url).send(:api_call, :put, params)
    end

    def self.delete(url, args={})
      new(url).send(:api_call, :delete)
    end

    private

    attr_accessor :url

    def api_call(method, params={})
      client.send(method, url, params) do |response, request, result, &blk|
      case response.code
        when 404, 422
          response
        else
          response.return!(request, result, &blk)
        end
      end
    end

    def client
      RestClient
    end
  end
end
