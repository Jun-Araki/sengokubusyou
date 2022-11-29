User.create!(email: "jun1@gmail.com", password: "password", nickname: "さな丸",
             profile: "真田幸村が大好きで、上田城などの史跡をめぐっています。戦国武将について語りたいので、ぜひよろしくお願いします。",
             user_image: File.open("db/fixtures/Sanada_Yukimura.jpg"), twitter: "TS1engineer")
User.create!(email: "guest@example.com", password: "password", nickname: "guest", profile: "よろしくお願いします。")
User.create!(email: "jun2@gmail.com", password: "password", nickname: "大江戸",
             profile: "主に関東を中心に歴史巡りをしています。最近はコロナもあって遠出できていないので、ここで情報を集めていきたいと思っています。よろしくお願いします。",
             user_image: File.open("db/fixtures/hugaku.jpeg"))
User.create!(email: "jun3@gmail.com", password: "password", nickname: "刀",
             profile: "刀剣乱舞の影響で日本刀に興味を持ち、そこから戦国武将にも興味を持ちました。みなさんと楽しく交流できたらいいなと思っています。",
             user_image: File.open("db/fixtures/katana.jpg"))
User.create!(email: "jun4@gmail.com", password: "password", nickname: "風来坊",
             profile: "現在、日本全国を旅しながら、各地の歴史や文化について学んでいるものです。実際に足を運んでみることで初めてわかることも数多く、そうした点を共有していきたいと持っています。",
             user_image: File.open("db/fixtures/huurai.png"))
User.create!(email: "jun5@gmail.com", password: "password", nickname: "独眼竜",
             profile: "仙台出身で伊達政宗が大好きです。現在は地元を離れていて、周りに歴史好きがいないので、ぜひよろしくお願いします。",
             user_image: File.open("db/fixtures/date.png"))
User.create!(email: "jun6@gmail.com", password: "password", nickname: "利休",
             profile: "大学時代に茶道を学んだ影響で千利休に興味があります。その千利休は多くの戦国武将に重宝されました。ここでも多くの人との関わりの中で、貴重な交流を図っていきたいです。",
             user_image: File.open("db/fixtures/sadou.png"))
User.create!(email: "jun7@gmail.com", password: "password", nickname: "雅",
             profile: "京都の大学に通っていたため、寺や神社などに興味を持っています。寺や神社は戦勝祈願にも使われるほど戦国武将と深い関わりがあり、自然と戦国武将にも興味を持ち始めました。よろしくお願いします。",
             user_image: File.open("db/fixtures/kyouto.png"))
User.create!(email: "jun8@gmail.com", password: "password", nickname: "足軽",
             profile: "最近歴史に興味を持った者です。歴史の勉強をしながら、学んだことをアウトプットしていきたいと思います。よろしくお願いします。",
             user_image: File.open("db/fixtures/asigaru.png"))
User.create!(email: "jun9@gmail.com", password: "password", nickname: "鉄砲隊",
             profile: "戦国武将の戦いに興味をもっている者です。鉄砲3段打ちなどで戦国最強の武田軍を撃退した「長篠の戦い」は非常に関心があります。その他、ここでしか話せない細かい話もしていきたいと思っています。",
             user_image: File.open("db/fixtures/teppou.png"))
User.create!(email: "jun10@gmail.com", password: "password", nickname: "下剋上",
             profile: "下剋上で成り上がった豊臣秀吉などの武将が好きです。これまでの官位によるものではなく、本当の力で築き上げた武将に魅力を感じています。よろしくお願いします。",
             user_image: File.open("db/fixtures/kattyuu.png"))

require "csv"

CSV.foreach("db/csv_data/post_data.csv", headers: true) do |row|
  Post.create!(image: File.open("#{Rails.root}/db/fixtures/#{row['image']}"),
               name: row["name"],
               kana: row["kana"],
               initial: row["initial"],
               prefecture: row["prefecture"],
               commentary: row["commentary"],
               user_id: row["user_id"])
end

10.times do |i|
  i += 1
  Like.create!(post_id: 93, user_id: i)
end
9.times do |i|
  i += 1
  Like.create!(post_id: 133, user_id: i)
end
8.times do |i|
  i += 1
  Like.create!(post_id: 137, user_id: i)
end
7.times do |i|
  i += 1
  Like.create!(post_id: 54, user_id: i)
end
6.times do |i|
  i += 1
  Like.create!(post_id: 116, user_id: i)
end
53.times do |i|
  i += 1
  Like.create!(post_id: i, user_id: 1)
end

2.upto(11) do |i|
  Relationship.create!(follower_id: 1, followed_id: i)
end
2.upto(11) do |i|
  Relationship.create!(follower_id: i, followed_id: 1)
end
3.upto(11) do |i|
  Relationship.create!(follower_id: 2, followed_id: i)
end

Comment.create!(user_id: 1, post_id: 93, content: "不遇の九度山時代から大坂の陣で大活躍したストーリーに感動した")
Comment.create!(user_id: 2, post_id: 93, content: "大坂の陣では圧倒的不利な中、徳川方を追い詰めたね")
Comment.create!(user_id: 3, post_id: 93, content: "大坂冬の陣では真田丸を築いて、ほぼ完璧にしのぎきったから凄いよ")
Comment.create!(user_id: 1, post_id: 93, content: "冬の陣の後に大坂城の堀が埋められなかったら、徳川政権も安泰でなかったと思うし")
Comment.create!(user_id: 2, post_id: 93, content: "でも大坂城の堀が埋められたから、夏の陣の勇姿があったということでもある")
Comment.create!(user_id: 1, post_id: 93, content: "夏の陣の決戦前の伊達政宗との戦いが激アツすぎる")
Comment.create!(user_id: 3, post_id: 93, content: "むしろ伊達勢を押してたし、普通に戦闘力あるよ")
Comment.create!(user_id: 1, post_id: 93, content: "夏の陣では家康が自害を決め込むほどの突撃だったんだよな")
Comment.create!(user_id: 4, post_id: 93, content: "本当にあと一歩だったけど、そういう姿に多くの人が感動するんだよね")
Comment.create!(user_id: 1, post_id: 93, content: "そうだよ！あの徳川家康も真田のことは後世に語り継いでよいことにしてたくらいだし")

Comment.create!(user_id: 2, post_id: 54, content: "安土城跡に行ってきたけど、ここに天主閣があったと思うと感激")
Comment.create!(user_id: 5, post_id: 54, content: "確かに当時は滋賀の琵琶湖周辺が京に近くて栄えてたんだよね")
Comment.create!(user_id: 2, post_id: 54, content: "信長の革新的なところが凄いと思うよ")
Comment.create!(user_id: 8, post_id: 54, content: "楽市楽座、農兵分離、鉄砲の導入などが挙げられるか")
Comment.create!(user_id: 2, post_id: 54, content: "あとはこれだけの軍隊をまとめる統率力も素晴らしいね")
Comment.create!(user_id: 5, post_id: 54, content: "そう思うと明智光秀をもっと大切にしていればなーと考えてしまうけどね")

Comment.create!(user_id: 6, post_id: 116, content: "戦国最強の騎馬軍団")
Comment.create!(user_id: 7, post_id: 116, content: "山本勘助をはじめとする家臣団がすごかったね")
Comment.create!(user_id: 6, post_id: 116, content: "信玄が西上作戦は後一歩のところまで来てたし")
Comment.create!(user_id: 1, post_id: 116, content: "そうね。もう少し長生きしていれば、長篠の戦いで織田・徳川に勝っていたかもしれない")
Comment.create!(user_id: 9, post_id: 116, content: "そう思うとロマンが広がるよ")
