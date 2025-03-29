# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Members

nicknames = ['mitoma', 'karina', 'sakura', 'winter', 'ninnin', 'kamata', 'poo', 'akane', 'ruri', 'miku',
             'tomoka', 'moeno', 'ryoka', 'kensyu', 'shoki', 'sou', 'reo', 'ryu', 'momoka', 'kazu',
             'azuki', 'haruka', 'banana', 'yuuki', 'nano', 'miu', 'koi', 'atomu', 'achi', 'koromo', 'mizu', 'pen']

32.times do |i|
  number = format('%06d', i + 1)
  
  Member.find_or_create_by(email: "test#{i + 1}@example.com") do |member|
    member.nickname = nicknames[i]
    member.birth_year = rand(1965..2014)
    member.gender = rand(0..2)
    member.is_active = true
    member.password = number
  end
end



# Categories
category_names = [
  '早起き',
  '早寝(睡眠)',
  'ウォーキング',
  'ランニング',
  '筋トレ',
  'Yoga・pilates',
  '食事管理',
  'cancel界隈'
]

category_names.each do |name|
  Category.create(name: name)
end



# Groups
# 日本語のキーだから =>を使う
group_data = {
  '早起き' => [
    ['Morning Boosters', '毎朝30分だけ早起きして、自分の時間を楽しもう！'],
    ['Sunrise Club', '朝日を浴びて、心と体をリセットしよう！'],
    ['早起きチャレンジ', '5時台に起きる仲間たちと一緒に頑張ろう！'],
    ['朝活のススメ', '朝の1時間を充実させたい人集合！']
  ],
  '早寝(睡眠)' => [
    ['SleepyHeads', '22時に寝ることを目指して、生活リズムを整えよう！'],
    ['ぐっすり隊', '質のいい睡眠をとって、毎日元気に！'],
    ['睡眠記録部', '睡眠時間と質をゆるっと記録していこう！'],
    ['夜ふかし卒業クラブ', 'ついつい夜更かししちゃう人集まれ！']
  ],
  'ウォーキング' => [
    ['Walk Walk Club', '1日30分、気持ちよく歩こう！'],
    ['ゆるウォーク部', '歩数よりも「歩く時間」を大事にしてるよ！'],
    ['街歩き好き集まれ', 'お散歩コースをシェアしよう！'],
    ['朝さんぽ同好会', '朝のウォーキングで1日をスタート！']
  ],
  'ランニング' => [
    ['Fun Runners', 'ゆるく楽しく、走る習慣をつけよう！'],
    ['朝ラン部', '朝にランニングして気分スッキリ！'],
    ['走るのキライじゃない', '走るの苦手でもOK！まずは週1から'],
    ['ランログを残そう', '走った記録をシェアしてモチベUP！']
  ],
  '筋トレ' => [
    ['筋トレ初心者会', 'まずは3分の筋トレから！'],
    ['おうちトレ部', '家でできる筋トレをシェアしよう！'],
    ['今日の筋肉日記', 'やったことを記録して続けよう！'],
    ['筋トレ応援団', '続けるコツを教え合おう！']
  ],
  'Yoga・pilates' => [
    ['ゆるヨガ部', '寝る前にちょこっとヨガでリラックス。'],
    ['朝ヨガの会', '呼吸を整えて、朝をスッキリ始めよう！'],
    ['おうちピラティス', 'おうち時間で体幹トレーニング！'],
    ['柔軟性チャレンジ', '開脚や前屈、ちょっとずつ伸ばしていこう！']
  ],
  '食事管理' => [
    ['食ログ部', '食べたものを記録して意識アップ！'],
    ['ゆる糖質制限', 'ゆる〜く糖質を意識してみよう！'],
    ['今日のごはん報告', '写真でも文字でもOK、ごはんを記録！'],
    ['野菜ちゃんと食べ隊', '野菜多めを目指して、健康ごはん！']
  ],
  'cancel界隈' => [
    ['風呂キャン', '毎日お風呂入ろ！'],
    ['SNS時間見直し隊', 'SNS時間、気づかないうちに長くなってない？'],
    ['ストレス断ちクラブ', 'ストレス発散方法を見つけよう！'],
    ['依存卒業チャレンジ', 'スマホ・カフェイン・ゲーム...一緒に減らそ！']
  ]
}

# 全グループをリストにまとめ
all_groups = []
group_data.each do |category_name, group_list|
  category = Category.find_by(name: category_name)

  group_list.each do |group_name, intro|
    all_groups << { name: group_name, intro: intro, category_id: category.id }
  end
end

owners = Member.order(:id).limit(16)
i = 0
all_groups.each do |group_info|
  owner = owners[i % 16] # 16人を順番にループで使う

  group = Group.find_or_create_by(name: group_info[:name]) do |g|
    g.introduction = group_info[:intro]
    g.category_id = group_info[:category_id]
    g.owner_id = owner.id
  end

  puts "✅ グループ『#{group.name}』のオーナーは『#{owner.nickname}』"
  # オーナーをグループに入会する
  Membership.find_or_create_by(member_id: owner.id, group_id: group.id)
  
  i += 1
end



# Memberships (グループ参加)
asc_members = Member.where(id: 17..32).order(id: :asc).to_a
desc_members = Member.where(id: 17..32).order(id: :desc).to_a
groups = Group.order(:id).to_a

i = 0
16.times do |i|
  Membership.find_or_create_by(member_id: asc_members[i].id, group_id: groups[i].id)
end

16.times do |i|
  Membership.find_or_create_by(member_id: desc_members[i].id, group_id: groups[i].id)
end
Membership.find_or_create_by(member_id: Member.first.id, group_id: groups[5].id)



# Posts
posts = [
  '今日も完了！おつかれ自分！',
  'ちょっとだけでもできたからOK🙆‍♀️',
  'やる前よりスッキリした〜！',
  '昨日より少し成長した気がする',
  '気分がリセットされた気がする☀️',
  'やった、自分、天才。（たぶん）',
  '奇跡的にやる気が出たので報告です',
  '3分やったし、もはや今日は優勝🏆',
  'えらすぎて自分にスタンディングオベーション',
  'SuRuに書いたら達成したことにしていいって聞きました'
]

members = Member.order(:id).to_a

32.times do
  member = members.sample
  group = member.groups.sample
  Post.create(member_id: member.id, group_id: group.id, content: posts.sample)
end



# Comments

member = Member.find(1)

# そのメンバー自身の投稿を除いた中から1件ランダムに選ぶ
post = Post.where.not(member_id: member.id).sample

Comment.create(member_id: member.id, post_id: post.id, content: ' いいね! ')


# Likes
Like.create(member_id: member.id, post_id: post.id)


admin = Admin.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.password = '000000'
end

puts "✅ seedファイルOK！"
