require 'spec_helper'

describe WireIO do
  before :each do
    @wio_client = WireIO::Client.new(@public_key, @private_key)
    @bad_client = WireIO::Client.new(@bad_public_key, @bad_private_key)
  end
  
  it "should return true if we fired the event successfully" do
    @wio_client.on('awesome-event', {
      :username => 'luke'
    }).should be_true
  end
  
  it "should return false if we fired the event unsuccessfully" do
    @bad_client.on('awesome-event', {
      :username => 'luke'
    }).should_not be_true
  end
  
  it "should return the correct current api version" do
    WireIO::Client::API_VERSION.should eql('v1')
  end
  
end