require "rails_helper"

RSpec.describe Relationship, type: :model do
  describe "バリデーション" do
    it "followerとfollowedが異なる場合は有効" do
      relationship = build(:relationship, follower: create(:user), followed: create(:user))
      expect(relationship).to be_valid
    end

    it "同じフォロー関係の重複は無効" do
      relationship = create(:relationship)
      duplicate = build(:relationship, follower: relationship.follower, followed: relationship.followed)
      expect(duplicate).to be_invalid
    end

    it "自分自身をフォローすることはできない" do
      user = create(:user)
      relationship = build(:relationship, follower: user, followed: user)
      expect(relationship).to be_invalid
    end
  end
end
