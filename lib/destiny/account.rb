# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::Account class is for acceessing information about a user's
  # account via the Destiny API
  class Account
    def initialize(client)
      @client = client
    end

    # Returns a list of Destiny memberships given a full Gamertag or PSN ID
    #
    # @param membership_type [Fixnum, String] A numeric representation of the
    #   platform used by the member to play Destiny
    # @param display_name [String] The user's Gamertag or PSN username.
    # @return [Hash] A hash representation of the destiny player(s) found.
    def search_destiny_player(membership_type, display_name)
      response = @client.get "Destiny/SearchDestinyPlayer/#{membership_type}/#{display_name}"
      response = Destiny::Client.validate response
      @membership_id ||= response['Response'][0]['membershipId']

      response
    end

    # Returns Destiny account information for the supplied membership in a
    # compact summary form. Will return vault information even if you're not
    # that account. Don't you want to be a cool kid and use this service
    # instead of GetAccount?
    #
    # @param membership_type [Fixnum, String] A number representing the platform
    #   used by the member to play Destiny.
    # @param member_id [Fixnum, String] The UUID of the member
    # @return [Hash] A hash representation of the user's account.
    def summary(membership_type, username)
      search_destiny_player membership_type, username
      response = @client.get "Destiny/#{membership_type}/Account/#{@membership_id}/Summary"
      Destiny::Client.validate response
    end
  end
end
