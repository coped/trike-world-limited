User.create!(name:  "Example User",
             road_name: "Shadow Rider",
             email: "example@user.com",
             password:              "foobar",
             password_confirmation: "foobar")

User.create!(name:  "Another User",
             road_name: "Big Daddy",
             email: "another@user.com",
             password:              "foobar",
             password_confirmation: "foobar")

Post.create!(title: "Example Title",
             body:  "This is the body for this post.",
             user_id: 1)

Post.create!(title: "Another Title",
             body:  "Oh, man. Another post!",
             user_id: 1,
             created_at: Time.now - 1_000_000,
             updated_at: Time.now - 500_000)
             
Post.create!(title: "Yet Another Title",
             body:  "Something creative",
             user_id: 2,
             created_at: Time.now - 2_000_000)