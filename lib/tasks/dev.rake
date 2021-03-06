namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
      file_admin = File.open("#{Rails.root}/public/avatar/user#{rand(1..20)}.jpg")
      User.create(
        email: "admin@gmail.com",
        password: "123456", 
        name: "Admin",
        introduction: "Administrator",
        avatar: file_admin, 
        role: "admin"
        )
      puts "admin has created"
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      rand(20).times do
        user.tweets.create(
            description: FFaker::Lorem::sentence(8)
          )
      end
    end
    puts "create fake tweets"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    300.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      Reply.create(
        user: user, 
        tweet: tweet, 
        comment: FFaker::Lorem::sentence(8)
        )
    end
    puts "create fake replies"
  end

  task fake_follow: :environment do
     500.times do
        user = User.all.sample
        tweet = Tweet.all.sample
        unless tweet.likes.create(user: user)
          return
        end
      end
      puts"create fake likes"
    end

      User.all.each do |user|
      followings = User.all.sample(rand(1..20))
      if followings.include?(user)
        followings.delete(user)
      end
      for following in followings
        user.followships.create!(following: following)
      end
    end
    puts "create fake_follow"
  end
end
