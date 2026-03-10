require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    let(:user) { create(:user) }
    let(:post) { build(:post, user:) }

    it "全ての属性が正しい場合は有効" do
      expect(post).to be_valid
    end

    it "nameが空の場合は無効" do
      post.name = nil
      expect(post).to be_invalid
    end

    it "nameが30文字を超える場合は無効" do
      post.name = "あ" * 31
      expect(post).to be_invalid
    end

    it "nameが重複する場合は無効" do
      create(:post, name: "織田信長", user:)
      duplicate_post = build(:post, name: "織田信長", user:)
      expect(duplicate_post).to be_invalid
    end

    it "kanaが空の場合は無効" do
      post.kana = nil
      expect(post).to be_invalid
    end

    it "initialが空の場合は無効" do
      post.initial = nil
      expect(post).to be_invalid
    end

    it "prefectureが空の場合は無効" do
      post.prefecture = nil
      expect(post).to be_invalid
    end

    it "commentaryが空の場合は無効" do
      post.commentary = nil
      expect(post).to be_invalid
    end
  end

  describe "スコープ" do
    let(:user) { create(:user) }

    describe ".by_initial" do
      it "指定した行の武将を取得する" do
        post_a = create(:post, initial: "あ行", user:)
        create(:post, initial: "か行", user:)
        expect(Post.by_initial("あ行")).to eq([post_a])
      end
    end

    describe ".by_prefecture" do
      it "指定した都道府県の武将を取得する" do
        post_tokyo = create(:post, prefecture: "東京都", user:)
        create(:post, prefecture: "大阪府", user:)
        expect(Post.by_prefecture("東京都")).to eq([post_tokyo])
      end
    end
  end

  describe ".search_with_initial" do
    let(:user) { create(:user) }

    it "initialが指定されている場合はby_initialを返す" do
      post_a = create(:post, initial: "あ行", user:)
      create(:post, initial: "か行", user:)
      q, posts_match = Post.search_with_initial({ initial: "あ行" })

      expect(q).to be_a(Ransack::Search)
      expect(posts_match).to eq([post_a])
    end

    it "initialが指定されていない場合はransackの結果を返す" do
      post_a = create(:post, initial: "あ行", user:)
      post_k = create(:post, initial: "か行", user:)
      _q, posts_match = Post.search_with_initial({ q: {} })

      expect(posts_match).to match_array([post_a, post_k])
    end
  end

  describe ".top_ids_by_likes" do
    let(:user) { create(:user) }

    it "いいね数の多い順にpost_idを返す" do
      post_a = create(:post, user:)
      post_b = create(:post, user:)
      create(:like, user:, post: post_b)
      create(:like, user: create(:user), post: post_b)
      create(:like, user: create(:user), post: post_a)

      expect(Post.top_ids_by_likes(2)).to eq([post_b.id, post_a.id])
    end
  end

  describe ".top_ids_by_comments" do
    let(:user) { create(:user) }

    it "コメント数の多い順にpost_idを返す" do
      post_a = create(:post, user:)
      post_b = create(:post, user:)
      create(:comment, user:, post: post_b)
      create(:comment, user: create(:user), post: post_b)
      create(:comment, user: create(:user), post: post_a)

      expect(Post.top_ids_by_comments(2)).to eq([post_b.id, post_a.id])
    end
  end

  describe ".prefecture_label" do
    it "都道府県の値から表示名を返す" do
      expect(Post.prefecture_label("13")).to eq("東京都")
    end
  end

  describe ".index_bundle" do
    let(:user) { create(:user) }

    it "検索結果と一覧を返す" do
      older = create(:post, created_at: 2.days.ago)
      newer = create(:post, created_at: 1.day.ago)

      result = Post.index_bundle({ q: {} }, user)

      expect(result[:q]).to be_a(Ransack::Search)
      expect(result[:posts_match]).to match_array([older, newer])
      expect(result[:posts].map(&:id)).to eq([older.id, newer.id])
    end
  end

  describe ".prefecture_bundle" do
    let(:user) { create(:user) }

    it "都道府県に一致する一覧と表示名を返す" do
      tokyo_post = create(:post, prefecture: "東京都")
      create(:post, prefecture: "大阪府")

      result = Post.prefecture_bundle({ prefecture: "東京都" }, user)

      expect(result[:posts_select]).to eq([tokyo_post])
      expect(result[:posts]).to eq([tokyo_post])
      expect(result[:post_display]).to eq("東京都")
    end
  end

  describe ".rankings_bundle" do
    let(:user) { create(:user) }

    it "いいね/コメントのランキングを返す" do
      post_a = create(:post)
      post_b = create(:post)
      user1 = create(:user)
      user2 = create(:user)

      create(:like, user: user1, post: post_a)
      create(:like, user: user2, post: post_a)
      create(:like, user: user1, post: post_b)

      create(:comment, user: user1, post: post_b)
      create(:comment, user: user2, post: post_b)
      create(:comment, user: user1, post: post_a)

      result = Post.rankings_bundle(user)

      expect(result[:likes].first).to eq(post_a)
      expect(result[:comments].first).to eq(post_b)
    end
  end

  describe ".top_likes" do
    it "いいね数上位の投稿を返す" do
      post = create(:post)
      create(:like, user: create(:user), post:)

      result = Post.top_likes

      expect(result).to include(post)
    end
  end

  describe "#liked_by?" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    it "いいね済みの場合trueを返す" do
      create(:like, user:, post:)
      expect(post.liked_by?(user)).to be true
    end

    it "いいねしていない場合falseを返す" do
      expect(post.liked_by?(user)).to be false
    end
  end
end
