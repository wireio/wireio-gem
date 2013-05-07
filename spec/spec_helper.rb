require 'rspec'
require 'webmock/rspec'
require 'signature'
require 'json'
require 'wireio'

RSpec.configure do |config|
  config.before(:each) do
    @private_key  = '66c39495adea26e246965f09'
    @public_key   = '9a5b4eaea5dd275c'
    
    @bad_private_key  = 'skywalker'
    @bad_public_key   = 'jedi'
    
    valid_uri    = 'https://app.getwire.io/api/v1/events/awesome-event/fire'
    params = {
      :username => 'luke'
    }
    request = Signature::Request.new('POST', valid_uri, params)
    
    auth_hash = request.sign(Signature::Token.new(@public_key, @private_key))
    bad_hash = request.sign(Signature::Token.new(@bad_public_key, @bad_private_key))
    
    ## Let's start fresh again
    WebMock.reset!
    
    ## Lock it down
    WebMock.disable_net_connect!
    
    ## Simulates a valid request to fire an event.
    stub_http_request(:post, valid_uri).
      with(:body => {:payload => params.merge(auth_hash)}).
      to_return(:body => "200 FIRED\n", :status => 200)
      
    ## Simulates an invalid request to fire an event.
    stub_http_request(:post, valid_uri).
      with(:body => {:payload => params.merge(bad_hash)}).
      to_return(:body => "401 UNAUTHORIZED\n", :status => 401)
  end
end