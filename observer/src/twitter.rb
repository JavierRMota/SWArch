# File name: twitter.rb
# Observer Method Pattern
# Date: 29-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

#Twitter class
class Twitter

    #Creates a new user, with 0 followers
    def initialize(name)
        @name = name
        @followers = []
    end

    #Notifies followers of the content provided
    def tweet(content)
        @followers.each do |follower|
            puts("#{follower.name} received a tweet from #{@name}: #{content}" )
        end
    end

    #Calls subscribe follower of the given user with self as parameter
    def follow(user)
        user.add_follower(self)
        self
    end

    #Adds follower to a given user
    def add_follower(user)
        @followers << user
    end

    #Returns the name of the user
    def name
        @name
    end
end