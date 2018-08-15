require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:photos_comments) { {profile_url: 'https://www.instagram.com/test', photo_id: "BiagiYOnElJ", comment_content: 'Sample comment ASD'} }
  describe "#save_photo_comments" do
    context 'when commenting user exists in db' do
      it 'create comment and increment user comments count' do
        user = FactoryBot.create(:user)
        expect { described_class.save_photos_comments([photos_comments]) }.to change { User.last.comments_count }
        expect(Comment.last.content).to eq photos_comments[:comment_content]
      end
    end

    context "when commenting user doesn't exists in db" do
      it 'create new user and save his comment' do
        expect { described_class.save_photos_comments([photos_comments]) }.to change { User.count }
        expect(User.find_by(profile_url: photos_comments[:profile_url]).comments_count).to eq 1
        expect(Comment.last.content).to eq photos_comments[:comment_content]
      end
    end
  end

end