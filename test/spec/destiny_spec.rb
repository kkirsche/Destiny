require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should have a version number' do
      expect(::Destiny::VERSION).wont_be_nil
    end

    it 'should create a Destiny client instance' do
      client = Destiny::Client.new ENV['X_API_Key']
      expect(client).must_be_instance_of Destiny::Client
    end
  end
end
