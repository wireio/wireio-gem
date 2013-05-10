# Wireio

Ruby client library for WireIO rest api. Developers can trigger events from their Ruby or Rack applications
(Ruby on Rails, Sinatra, ...etc.)

## Installation

Add this line to your application's Gemfile:

    gem 'wireio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wireio

## Usage

Using the library is straight forward, first you need initialize the client with your application keys
		
		@public_key = "awesome_public_key"
		@private_key = "awesome_private_key"
		@wio = WireIO::Client.new(@public_key, @private_key)

Then to trigger an event
		
		@wio.on('jedi-boarding-ship', {:nick => 'luke'})


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
