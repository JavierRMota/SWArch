class Twitter
    def initialize(name)
        @name = name
        @followers = []
    end
    def tweet(content)
        @followers.each do |follower|
            puts("#{follower.name} received a tweet from #{@name}: #{content}" )
        end
    end
    def follow(user)
        user.add_follower(self)
        self
    end
    def add_follower(user)
        @followers << user
    end
    def name
        @name
    end
end