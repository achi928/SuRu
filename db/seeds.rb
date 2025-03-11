# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Members
beauty_lover = Member.find_or_create_by(email: 'beauty@example.com') do |member|
  member.nickname = 'BeautyLover'
  member.birth_year = 1995
  member.gender = 1  # Female
  member.is_active = true
  member.password = '111111'
end

health_fan = Member.find_or_create_by(email: 'health@example.com') do |member|
  member.nickname = 'HealthFan'
  member.birth_year = 1990
  member.gender = 2  # Male
  member.is_active = true
  member.password = '222222'
end

# Categories
beauty = Category.find_or_create_by(name: 'Beauty')
health = Category.find_or_create_by(name: 'Health')

# Groups
skin_care_group = Group.find_or_create_by(name: 'SkinCareLovers') do |group|
  group.category_id = beauty.id
  group.owner_id = beauty_lover.id
  group.introduction = 'Let’s share skincare tips!'
end

morning_run_group = Group.find_or_create_by(name: 'MorningRunClub') do |group|
  group.category_id = health.id
  group.owner_id = health_fan.id
  group.introduction = 'Morning run buddies wanted!'
end

# Memberships (グループ参加)
Membership.find_or_create_by(member_id: beauty_lover.id, group_id: skin_care_group.id)
Membership.find_or_create_by(member_id: health_fan.id, group_id: morning_run_group.id)

# Group Posts
skin_care_post = GroupPost.find_or_create_by(member_id: beauty_lover.id, group_id: skin_care_group.id) do |post|
  post.content = 'What’s your favorite toner?'
end

morning_run_post = GroupPost.find_or_create_by(member_id: health_fan.id, group_id: morning_run_group.id) do |post|
  post.content = 'Ran 5km this morning!'
end

# Comments
Comment.find_or_create_by(member_id: health_fan.id, group_post_id: skin_care_post.id) do |comment|
  comment.content = 'I love rose water toner!'
end

Comment.find_or_create_by(member_id: beauty_lover.id, group_post_id: morning_run_post.id) do |comment|
  comment.content = 'That’s amazing! Keep it up!'
end

# Likes
Like.find_or_create_by(member_id: beauty_lover.id, group_post_id: morning_run_post.id)
Like.find_or_create_by(member_id: health_fan.id, group_post_id: skin_care_post.id)

admin = Admin.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.password = '000000'
end

puts "✅ seedファイルOK！"
