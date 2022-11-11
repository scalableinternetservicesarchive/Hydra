# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

USER_NUM = 1024
GROUP_NUM = 128
GROUP_PER_USER = 10

# User definition
#     t.string "username"
#     t.string "password_digest"
#     t.string "email"
#     t.text "about"
#     t.string "pic_url"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.string "status"
# user = User.new(username:'Amy', password:'123', password_confirmation:'123', email:'amy@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Andy', password:'123', password_confirmation:'123', email:'andy@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Bob', password:'123', password_confirmation:'123', email:'bob@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Dany', password:'123', password_confirmation:'123', email:'dany@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Lucy', password:'123', password_confirmation:'123', email:'lucy@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Sara', password:'123', password_confirmation:'123', email:'sara@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Iris', password:'123', password_confirmation:'123', email:'iris@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Ethan', password:'123', password_confirmation:'123', email:'ethan@example.com', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Mingrui Xu', password:'123', password_confirmation:'123', email:'mingrui@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Md Shafiuzzaman', password:'123', password_confirmation:'123', email:'shafi@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Luqing Cheng', password:'123', password_confirmation:'123', email:'luqing@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Zihao Su', password:'123', password_confirmation:'123', email:'zihao@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Ye Yuan', password:'123', password_confirmation:'123', email:'yeyuan@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
# user = User.new(username:'Joyce Passananti', password:'123', password_confirmation:'123', email:'joyce@ucsb.edu', about:'I am XXXXX, this is my profile.', pic_url:'https://picsum.photos/200', status:'offline')
# user.save
(1..USER_NUM).each do |i|
  user = User.new(username:"Dummy User-#{i}", password:'123', password_confirmation:'123', email:"user#{i}@test.org", about:'I am XXXXX, this is my profile.', pic_url:"https://picsum.photos/200?random=#{i}", status:'offline')
  user.save
end

# Group definitions
#     t.string "groupname"
#     t.string "pic_url"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
(1..GROUP_NUM).each do |i|
  group = Group.new(groupname: "Group-#{i}", pic_url: "https://picsum.photos/200?random=#{i}")
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


post = Post.new(user_id:'1', groupid:'0', message:'This is a test post message')
post = Post.new(user_id:'2', groupid:'0', message:'This is a test post message')
post = Post.new(user_id:'3', groupid:'0', message:'This is a test post message')

# Comment definition
# t.bigint "post_id", null: false
# t.bigint "user_id", null: false
# t.text "comment"
#  t.datetime "date"

comment = Comment.new(user_id:'2', post_id:'1', comment:'This is a test comment')
comment = Comment.new(user_id:'4', post_id:'1', comment:'This is a test comment')
comment = Comment.new(user_id:'5', post_id:'1', comment:'This is a test comment')

# Message definition
# t.bigint "from_user_id", null: false
# t.bigint "to_user_id", null: false
# t.text "message"
# t.datetime "date"


#
# post = Post.new(user_id:user.id,groupid:group.id,message:'this is a test post message')
# post.save

