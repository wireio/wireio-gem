require 'rspec'
require 'webmock/rspec'
require 'signature'
require 'wireio'

RSpec.configure do |config|
  config.before(:each) do
    @private_key  = '66c39495adea26e246965f09'
    @public_key   = '9a5b4eaea5dd275c'
    
    valid_uri    = 'https://app.getwire.io/api/v1/events/awesome-event/fire'
    params = {
      :payload => { :username => 'luke' }
    }
    request = Signature::Request.new('POST', valid_uri, params)
    auth_hash = request.sign(Signature::Token.new(@public_key, @private_key))
    
    ## Let's start fresh again
    WebMock.reset!
    ## Simulates a valid request to fire an event.
    WebMock.stub_request(:post, valid_uri).
      with(:body => {params.merge(auth_hash)}).
      to_return(:body => "200 FIRED\n", :status => 200)
  end
end