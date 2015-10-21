require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    before do
      @client = Destiny::Client.new ENV['X_API_Key']
    end

    it 'should create a Destiny client instance' do
      expect(@client.manifest.full.keys).must_equal %w(Response ErrorCode
                                                       ThrottleSeconds
                                                       ErrorStatus
                                                       Message MessageData)
    end
  end
end
