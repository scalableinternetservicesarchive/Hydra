# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# USER_NUM = 1024
# GROUP_NUM = 128
# GROUP_PER_USER = 10

USER_NUM = 4096
GROUP_NUM = 256
GROUP_PER_USER = 128
POST_PER_USER = 5
COMMENT_NUM = 16384
MESSAGE_DUPLICATE = 20

# User definition
#     t.string "username"
#     t.string "password_digest"
#     t.string "email"
#     t.text "about"
#     t.string "pic_url"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.string "status"
(1..USER_NUM).each do |i|
  user = User.new(username:"DummyUser#{i}", password:'123', password_confirmation:'123', email:"user#{i}@test.org", about:'I am XXXXX, this is my profile.', pic_url:"https://picsum.photos/200?random=#{i}", status:'offline')
  user.save
end

# Group definitions
#     t.string "groupname"
#     t.string "pic_url"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
(1..GROUP_NUM).each do |i|
  group = Group.new(groupname: "Group#{i}", pic_url: "https://picsum.photos/200?random=#{i}")
  group.save
end

# Group User definition
#     t.bigint "group_id", null: false
#     t.bigint "user_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.boolean "permission"
#     t.index ["group_id"], name: "index_group_users_on_group_id"
#     t.index ["user_id"], name: "index_group_users_on_user_id"
(1..USER_NUM).each do |i|
  range = (1..GROUP_NUM).to_a
  group_list = range.sample(GROUP_PER_USER)
  group_list.each do |g|
    group_user = GroupUser.new(group_id:g,user_id:i,permission:true)
    group_user.save
  end
end


# Post definition
# t.bigint "user_id", null: false
# t.integer "groupid"
# t.text "message"
# t.datetime "date"
(1..USER_NUM).each do |u|
  (1..POST_PER_USER).each do |index|
    post = Post.new(user_id:u, groupid:0, message:"[#{index}/#{POST_PER_USER}] This is a test post message from user #{u} and visible to all")
    post.save
  end
  group_list = GroupUser.where(user_id: u)
  group_list.each do |g|
    post = Post.new(user_id:u, groupid:g.id, message:"This is a test post message from user #{u} and visible to Group #{g.id}")
    post.save
  end
end

# Comment definition
# t.bigint "post_id", null: false
# t.bigint "user_id", null: false
# t.text "comment"
#  t.datetime "date"
(1..COMMENT_NUM).each do |i|
  comment = Comment.new(user_id:rand(1..USER_NUM), post_id:rand(1..Post.count), comment:'This is a test comment')
  comment.save
end

# Message definition
# t.bigint "from_user_id", null: false
# t.bigint "to_user_id", null: false
# t.text "message"
# t.datetime "date"
(1..USER_NUM).each do |from|
  (1..MESSAGE_DUPLICATE).each do |index|
    to = from-1>0 ? from-1 : USER_NUM
    message = Message.new(from_user_id:from, to_user_id:to, message:"[#{index}/#{MESSAGE_DUPLICATE}] Hello User #{to}, from User #{from}.")
    message.save
    to = from+1<=USER_NUM ? from+1 : 1
    message = Message.new(from_user_id:from, to_user_id:to, message:"[#{index}/#{MESSAGE_DUPLICATE}] Hello User #{to}, from User #{from}.")
    message.save
  end
end
  # range = (1..USER_NUM).to_a
  # users = range.sample(2)
  # message = Message.new(from_user_id:users[0], to_user_id:users[1], message:"Hello User #{users[1]}, from User #{users[0]}.")
  # message.save