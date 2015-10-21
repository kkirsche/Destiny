module Destiny
  class Client
    def initialize(api_key)
      @client = Hurley::Client.new 'http://www.bungie.net/Platform/'
      @client.header['X-API-Key'] = api_key
    end

    def account
      @account ||= Destiny::Account.new @client
    end
  end
end
