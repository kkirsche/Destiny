require 'test_helper'

module DestinyTest
  describe 'Destiny Gem', 'The Destiny API Gem' do
    before do
      @client = Destiny::Client.new ENV['X_API_Key']
    end

    it 'should retrieve a user account' do
      response = @client.account.details ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal %w(Response ErrorCode
                                          ThrottleSeconds ErrorStatus
                                          Message MessageData)
    end

    it 'should retrieve a user item list' do
      response = @client.account.items ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal %w(Response ErrorCode
                                          ThrottleSeconds ErrorStatus
                                          Message MessageData)
    end

    it 'should retrieve a user membership ID' do
      valid_response = {
        'Response' => '4611686018433985673',
        'ErrorCode'=>1,
        'ThrottleSeconds'=>0,
        'ErrorStatus'=>'Success',
        'Message'=>'Ok',
        'MessageData'=>{}
      }
      response = @client.account.membership_id_from_display_name ENV['Membership_Type'], ENV['Display_Name']
      expect(response).must_equal valid_response
    end

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
      response = @client.account.search_destiny_player ENV['Membership_Type'],
                                                      ENV['Display_Name']
      expect(response).must_equal valid_response
    end

    it 'should retrieve a user account summary' do
      response = @client.account.summary ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal %w(Response ErrorCode
                                          ThrottleSeconds ErrorStatus
                                          Message MessageData)
    end

    it 'should retrieve a user account statistics' do
      response = @client.account.stats ENV['Membership_Type'],
                                        ENV['Display_Name']
      expect(response.keys).must_equal %w(Response ErrorCode
                                          ThrottleSeconds ErrorStatus
                                          Message MessageData)
    end
  end
end
