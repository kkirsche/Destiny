# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::Client class is the primary class used to interact
  # with the Destiny API
  class Client
    attr_accessor :account

    def initialize(api_key)
      @client = Hurley::Client.new 'http://www.bungie.net/Platform/'
      @client.header['X-API-Key'] = api_key
    end

    def account
      @account ||= Destiny::Account.new @client
    end

    def manifest
      @manifest ||= Destiny::Manifest.new @client
    end

    def self.validate(response)
      if response.success?
        JSON.parse response.body
      else
        raise 'There was a problem with the request'
      end
    end
  end
end
