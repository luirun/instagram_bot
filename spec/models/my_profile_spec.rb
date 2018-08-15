require 'rails_helper'

RSpec.describe MyProfile, type: :model do

  let(:profile) { FactoryBot.build(:my_profile) }
  let(:photo_details) { {url: 'https://www.instagram.com/p/BjCVGwKAoC6/?taken-by=woodworking_art', likes_count: 774, description: 'Photo description 123', created_at: '2018-05-21T10:37:57.000Z'} }
  describe "#login" do
    context 'when login with invalid credentials' do
      it 'returns error' do
        expect { profile.login }.to eq nil # TODO
      end
    end
  end

end