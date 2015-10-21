# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::Account class is for acceessing information about a user's
  # account via the Destiny API
  class Account
    def initialize(client)
      @client = client
      @membership_id = nil
    end

    # Returns a list of Destiny memberships given a full Gamertag or PSN ID
    #
    # @param membership_type [Fixnum, String] A numeric representation of the
    #   platform used by the member to play Destiny
    # @param display_name [String] The user's Gamertag or PSN username.
    # @return [Hash] A hash representation of the destiny player(s) found.
    def search_destiny_player(membership_type, display_name)
      response = @client.get "Destiny/SearchDestinyPlayer/#{membership_type}"\
                             "/#{display_name}"
      response = Destiny::Client.validate response
      @membership_id ||= response['Response'][0]['membershipId']

      response
    end

    # [Deprecated] Returns Destiny account information for the supplied
    # membership. This endpoint has been deprecated. Please use `summary`
    # instead, pretty please with sugar on top. Seriously, we'll be BFFs 4 evah.
    # Plus you can get at vault info without being logged in as that person, how
    # cool is that?
    #
    # @param membership_type [Fixnum, String] A number representing the platform
    #   used by the member to play Destiny.
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's account.
    def details(membership_type, username)
      search_destiny_player membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{membership_type}/Account/"\
                             "#{@membership_id}"
      Destiny::Client.validate response
    end

    # Returns Destiny account information for the supplied membership in a
    # compact summary form. Will return vault information even if you're not
    # that account. Don't you want to be a cool kid and use this service
    # instead of GetAccount?
    #
    # @param membership_type [Fixnum, String] A number representing the platform
    #   used by the member to play Destiny.
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's account.
    def summary(membership_type, username)
      search_destiny_player membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{membership_type}/Account/"\
                             "#{@membership_id}/Summary"
      Destiny::Client.validate response
    end

    # Returns information about all items for the supplied Destiny Membership ID
    # and a minimal set of character information so that it can be used.
    #
    # @param membership_type [Fixnum, String] A number representing the platform
    #   used by the member to play Destiny.
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's itmes.
    def items(membership_type, username)
      search_destiny_player membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{membership_type}/Account/"\
                             "#{@membership_id}/Items"
      Destiny::Client.validate response
    end
  end
end
