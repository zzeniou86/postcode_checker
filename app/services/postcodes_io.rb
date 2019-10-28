#nodoc
module PostcodesIo
  class Client
    include HTTParty
    base_uri 'https://api.postcodes.io'

    def initialize(options = {})
      @options = options
    end

    def lookup
      'to implement'
    end
  end
end
