require 'spec_helper'

describe WireIO do
  before :each do
    @wio_client = WireIO::Client.new(@public_key, @private_key)
  end
  
  it "should return true if we fired the event successfully" do
    @wio_client.on('awesome-event', {
      :username => 'luke'
    }).should be_true
  end
  
end