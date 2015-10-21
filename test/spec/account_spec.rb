require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should create a Destiny client instance' do
      client = Destiny::Client.new ENV['X_API_Key']
      expect(client.account.summary.body).must_be_instance_of Destiny::Client
    end
  end
end
