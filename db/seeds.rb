# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.new(username:'testuser',password_digest:'pass')
user.save

group = Group.new(groupname:'test group 1', pic_url:'https://i.picsum.photos/id/682/200/200.jpg?hmac=098XkPnTe9a41I6BtB9xV4t6L8c3ESkdowMLElFBR5A')
group.save

group_user = GroupUser.new(group_id:group.id,user_id:user.id,permission:true)
group_user.save

post = Post.new(user_id:user.id,groupid:group.id,message:'this is a test post message')
post.save