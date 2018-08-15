require 'rails_helper'

RSpec.describe Photo, type: :model do

  let(:page) { FactoryBot.build(:page) }
  let(:photo_details) { {url: 'https://www.instagram.com/p/BjCVGwKAoC6/?taken-by=woodworking_art', likes_count: 774, description: 'Photo description 123', created_at: '2018-05-21T10:37:57.000Z'} }
  describe "#save_photo_details" do
    it 'save new photo to db' do
      expect { described_class.save_photo_details(page.url, photo_details) }.to change { Photo.count }
    end
  end

end