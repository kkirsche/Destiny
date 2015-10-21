# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::User class is for acceessing information about a user's
  # user information via the Destiny API
  class User
    def initialize(client)
      @client = client
    end

    def bungie_account_details(bungienet_id)
      response = @client.get "User/GetBungieAccount/#{bungienet_id}/254"
      Destiny::Client.validate response
    end
  end
end
