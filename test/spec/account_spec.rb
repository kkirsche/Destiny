require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should search for a destiny player based on platform and username' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.search_destiny_player ENV['Membership_Type'],
                                                      ENV['Display_Name']
      expect(response).must_equal nil
    end
  end
end
