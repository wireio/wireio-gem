require "wireio/version"
require "restclient"
require "json"

module WireIO
  class Client
    API_VERSION     = 'v1'
    
    def initialize(public_key, private_key)
      @public_key, @private_key = public_key, private_key
      @base_uri     = 'https://app.getwire.io'
      @api_endpoint = "api/#{API_VERSION}/events"
      @action       = "fire"
    end
    
    def on(event_name, payload)
      end_point = construct_endpoint_for(event_name)
      payload.merge!(generate_auth_hash_for(end_point, payload))
      RestClient.post(end_point, JSON.dump({:payload => payload}), 
        :content_type => :json) { |response, _request, _result|
          case response.code
          when 200
            true
          else
            false
          end
        }
    end
    
    private
    def construct_endpoint_for(event_name)
      "#{@base_uri}/#{@api_endpoint}/#{event_name}/#{@action}"
    end
    
    def generate_auth_hash_for(end_point, payload)
      req = Signature::Request.new('POST', end_point, payload)
      req.sign(Signature::Token.new(@public_key, @private_key))
    end
    
  end
end
