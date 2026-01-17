# db/seeds.rb
user = User.find_by(email: "torachie0308@gmail.com")
if user
  user.update!(admin: true)
  puts "User #{user.email} is now an admin."
end