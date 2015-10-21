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

    # [Deprecated] Returns Destiny account information for the supplied
    # membership. This endpoint has been deprecated. Please use `summary`
    # instead, pretty please with sugar on top. Seriously, we'll be BFFs 4 evah.
    # Plus you can get at vault info without being logged in as that person, how
    # cool is that?
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's account.
    def details(membership_type, username)
      num_membership_type = find_membership_type_from membership_type
      membership_id_from_display_name num_membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{num_membership_type}/Account/"\
                             "#{@membership_id}"
      Destiny::Client.validate response
    end

    # Returns information about all items for the supplied Destiny Membership ID
    # and a minimal set of character information so that it can be used.
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's items.
    def items(membership_type, username)
      num_membership_type = find_membership_type_from membership_type
      membership_id_from_display_name num_membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{num_membership_type}/Account/"\
                             "#{@membership_id}/Items"
      Destiny::Client.validate response
    end

    # Returns the numerical id of a player based on their display name, zero if
    # not found.
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param display_name [String] The user's Gamertag or PSN username.
    # @return [Hash] A hash containing the membership ID
    def membership_id_from_display_name(membership_type, display_name)
      num_membership_type = find_membership_type_from membership_type
      response = @client.get "Destiny/#{num_membership_type}/Stats/"\
                             "GetMembershipIdByDisplayName/#{display_name}"
      response = Destiny::Client.validate response
      @membership_id ||= response['Response']

      response
    end

    # Returns a list of Destiny memberships given a full Gamertag or PSN ID
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param display_name [String] The user's Gamertag or PSN username.
    # @return [Hash] A hash representation of the destiny player(s) found.
    def search_destiny_player(membership_type, display_name)
      num_membership_type = find_membership_type_from membership_type
      response = @client.get "Destiny/SearchDestinyPlayer/#{num_membership_type}"\
                             "/#{display_name}"
      response = Destiny::Client.validate response
      @membership_id ||= response['Response'][0]['membershipId']

      response
    end

    # Returns Destiny account information for the supplied membership in a
    # compact summary form. Will return vault information even if you're not
    # that account. Don't you want to be a cool kid and use this service
    # instead of GetAccount?
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's account.
    def summary(membership_type, username)
      num_membership_type = find_membership_type_from membership_type
      membership_id_from_display_name num_membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/#{num_membership_type}/Account/"\
                             "#{@membership_id}/Summary"
      Destiny::Client.validate response
    end

    # Gets aggregate historical stats organized around each character for a
    # given account.
    #
    # @param membership_type [Symbol] :psn or :xbox_live
    # @param username [Fixnum, String] The members username / display name
    # @return [Hash] A hash representation of the user's aggregate statistics.
    def stats(membership_type, username)
      num_membership_type = find_membership_type_from membership_type
      membership_id_from_display_name num_membership_type, username if @membership_id.nil?
      response = @client.get "Destiny/Stats/Account/#{num_membership_type}/"\
                             "#{@membership_id}"
      Destiny::Client.validate response
    end

    private

    def find_membership_type_from(symbol_membership_type)
      if symbol_membership_type.respond_to? :to_sym
        key = symbol_membership_type.to_sym
        num_membership_type = Destiny::MEMBERSHIP_TYPES[key]
      elsif symbol_membership_type.class == Fixnum
        num_membership_type = symbol_membership_type
      else
        raise 'Unknown membership type found. Please use :psn or :xbox_live'
      end
      num_membership_type
    end
  end
end
