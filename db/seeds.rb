user = User.create!(name:  "Example User",
                    road_name: "Shadow Rider",
                    email: "example@user.com",
                    password:              "foobar",
                    password_confirmation: "foobar")

another_user = User.create!(name:  "Another User",
                            road_name: "Big Daddy",
                            email: "another@user.com",
                            password:              "foobar",
                            password_confirmation: "foobar")

user.posts.create!(title: "Example Title",
                   body:  "This is the body for this post.")

user.posts.create!(title: "Another Title",
                   body:  "Oh, man. Another post!",
                   created_at: Time.now - 1_000_000,
                   updated_at: Time.now - 500_000)
             
another_user.posts.create!(title: "Yet Another Title",
                           body:  "Something creative",
                           created_at: Time.now - 2_000_000)
