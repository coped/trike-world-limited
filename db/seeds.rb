User.create!(name:  "Example User",
             email: "example@user.com",
             password:              "foobar",
             password_confirmation: "foobar")

User.create!(name:  "Another User",
             email: "another@user.com",
             password:              "foobar",
             password_confirmation: "foobar")

Post.create!(title: "Example Title",
             body:  "This is the body for this post.",
             user_id: 1)

Post.create!(title: "Another Title",
             body:  "Oh, man. Another post!",
             user_id: 1)
             
Post.create!(title: "Yet Another Title",
             body:  "Something creative",
             user_id: 2)