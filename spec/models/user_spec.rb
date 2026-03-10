require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    let(:user) { build(:user) }

    it "全ての属性が正しい場合は有効" do
      expect(user).to be_valid
    end

    it "nicknameが空の場合は無効" do
      user.nickname = nil
      expect(user).to be_invalid
    end

    it "emailが空の場合は無効" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "profileが200文字を超える場合は無効" do
      user.profile = "あ" * 201
      expect(user).to be_invalid
    end
  end

  describe "フォロー機能" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    describe "#follow" do
      it "ユーザーをフォローできる" do
        user.follow(other_user)
        expect(user.following?(other_user)).to be true
      end
    end

    describe "#unfollow" do
      it "ユーザーのフォローを解除できる" do
        user.follow(other_user)
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be false
      end
    end

    describe "#following?" do
      it "フォローしている場合trueを返す" do
        user.follow(other_user)
        expect(user.following?(other_user)).to be true
      end

      it "フォローしていない場合falseを返す" do
        expect(user.following?(other_user)).to be false
      end
    end
  end

  describe ".guest" do
    it "ゲストユーザーを作成または取得する" do
      guest = User.guest
      expect(guest.email).to eq("guest@example.com")
      expect(guest.nickname).to eq("guest")
    end
  end
end
