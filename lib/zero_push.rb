require 'zero_push/version'
require 'faraday'

module ZeroPush
  URL = "http://www.zeropush.com"

  class << self
    attr_accessor :auth_token

    # verifies credentials
    #
    # @return [Boolean]
    def verify_credentials
      response = client.get('/api/verify_credentials')
      response.status == 200
    end

    # Sends a notification to the list of devices
    #
    # @param params [Hash]
    # @return response
    def notify(params)
      client.post('/api/notify', params)
    end

    # the HTTP client configured for API requests
    #
    def client
      Faraday.new(url: URL) do |c|
        c.token_auth  self.auth_token
        c.request     :url_encoded            # form-encode POST params
        c.adapter     Faraday.default_adapter # Net::HTTP
      end
    end
  end
end
