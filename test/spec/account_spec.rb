require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should create a Destiny client instance' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.summary ENV['Membership_Type'],
                                        ENV['Membership_ID']
      expect(response).must_equal nil
    end
  end
end
