#:nodoc
module PostcodesIo
  #:nodoc
  class Client
    include HTTParty
    base_uri 'api.postcodes.io'

    def initialize(options = {})
      @options = options
    end

    def lookup(postcode)
      self.class.get('/postcodes/' + postcode, @options).parsed_response
    end
  end
end
