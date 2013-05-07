require "wireio/version"
require "restclient"
require "json"
require "signature"

module WireIO
  class Client
    API_VERSION     = 'v1'
    
    def initialize(public_key, private_key)
      @public_key, @private_key = public_key.downcase, private_key.downcase
      @base_uri     = 'https://app.getwire.io'
      @api_endpoint = "api/#{API_VERSION}/events"
      @action       = "fire.json"
    end
    
    def on(event_name, payload)
      RestClient.post(construct_endpoint_for(event_name), 
        JSON.dump({
          :payload => payload, 
          :auth_hash =>  generate_auth_hash_for(@api_endpoint, payload)
        }), 
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
