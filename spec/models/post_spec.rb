require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    it "nameが空の場合は無効" do
      post = build(:post, name: nil)
      expect(post).to be_invalid
    end
  end
end
