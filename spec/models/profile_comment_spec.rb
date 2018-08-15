require 'rails_helper'

RSpec.describe ProfileComment, type: :model do

  let(:comment) { FactoryBot.build(:profile_comment) }
  describe "#spin" do
    it 'pick random words from brackets and return spinned comment' do
      expect(comment.spin).not_to include("|", "{", "}")
    end
  end

end