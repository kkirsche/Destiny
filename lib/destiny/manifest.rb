# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::Manifest class is for acceessing information about a user's
  # account via the Destiny API
  class Manifest
    def initialize(client)
      @client = client
      @membership_id = nil
    end

    # Returns the current version of the manifest as a json object.
    #
    # @return [Hash] A hash representation of the user's account.
    def full
      response = @client.get "Destiny/Manifest"
      Destiny::Client.validate response
    end
  end
end
