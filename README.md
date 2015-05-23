# Opal-Pusher

Opal-Pusher is a set of Ruby bindings for the Pusher API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opal-pusher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opal-pusher

## Usage

You'll need to pass your Pusher API key into your front-end app somehow. In Rails apps, I usually use the `gon` gem for this:

```ruby
gon.push pusher_api_key: ENV.fetch('PUSHER_API_KEY')
```

Once you have that accessible from the front-end, you can open up a Pusher connection in your Opal app like this:

```ruby
require 'pusher' # Load this library

pusher = Pusher.new(`gon.pusher_api_key`)
channel = pusher.subscribe("my-pusher-channel")
channel.bind "my-pusher-event" do |data|
  puts data # data is a hash
end
```

I've been using this to set the attributes of models in Clearwater apps:

```ruby
foo_channel.bind 'update' do |data|
  FooRepository[data[:id]].set_attributes data
  App.render # Rerender the app with new data
end
```

## Contributing

1. Fork it ( https://github.com/jgaskins/opal-pusher/fork )
2. Branch it (`git checkout -b brand-new-thing`)
3. Hack it
4. Save it
5. Commit it (`git commit -am 'Do the thing'`)
6. Push it (`git push origin brand-new-thing`)
7. Pull-request it
