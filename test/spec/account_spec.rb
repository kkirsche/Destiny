require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    it 'should search for a destiny player based on platform and username' do
      valid_response = {
        'Response' => [
          {
            'iconPath' => '/img/theme/destiny/icons/icon_psn.png',
            'membershipType' => 2,
            'membershipId' => '4611686018433985673',
            'displayName' => 'R4z3rsPar4d0x'
          }
        ],
        'ErrorCode' => 1,
        'ThrottleSeconds' => 0,
        'ErrorStatus' => 'Success',
        'Message' => 'Ok',
        'MessageData' => {}
      }
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.search_destiny_player ENV['Membership_Type'],
                                                      ENV['Display_Name']
      expect(response).must_equal valid_response
    end

    it 'should retrieve a user account summary' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.summary ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal ['Response', 'ErrorCode',
                                        'ThrottleSeconds', 'ErrorStatus',
                                        'Message', 'MessageData']
    end

    it 'should retrieve a user account' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.details ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal ['Response', 'ErrorCode',
                                        'ThrottleSeconds', 'ErrorStatus',
                                        'Message', 'MessageData']
    end

    it 'should retrieve a user item list' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.items ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal ['Response', 'ErrorCode',
                                        'ThrottleSeconds', 'ErrorStatus',
                                        'Message', 'MessageData']
    end

    it 'should retrieve a user account statistics' do
      client = Destiny::Client.new ENV['X_API_Key']
      response = client.account.stats ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal ['Response', 'ErrorCode',
                                        'ThrottleSeconds', 'ErrorStatus',
                                        'Message', 'MessageData']
    end
  end
end
