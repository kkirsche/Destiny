# The Destiny module namespaces all functionality which interacts with
# the Bungie API for Destiny (video game for PS3, PS4, Xbox 360, and Xbox One)
module Destiny
  # The Destiny::Account class is for acceessing information about a user's
  # account via the Destiny API
  class Account
    def initialize(client)
      @client = client
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
    def summary(membership_type, member_id)
      response = @client.get "#{membership_type}/Account/#{member_id}/Summary"
      validate response
    end

    private

    def validate(response)
      JSON.parse(response.body) if response.success?
    end
  end
end
