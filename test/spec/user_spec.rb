require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should retrieve the users account details' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.user.bungie_account_details ENV['BungieNet_ID']
      puts response
      expect(response).must_equal nil
    end
  end
end
