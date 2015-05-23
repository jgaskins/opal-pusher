class Pusher
  def initialize(api_key)
    if `!window.Pusher`
      raise NotImplementedError, 'Pusher is not yet loaded. Make sure you load the Pusher JS library from the Pusher site before trying to instantiate it from your Opal app.'
    end

    @pusher = `new Pusher(api_key)`
  end

  def subscribe channel
    Channel.new(`#@pusher.subscribe(channel)`)
  end

  class Channel
    def initialize channel
      @channel = channel
    end

    def bind event
      handler = proc do |data|
        yield Hash.new(data) if block_given?
      end
      `#@channel.bind(event, handler)`
    end
  end
end

