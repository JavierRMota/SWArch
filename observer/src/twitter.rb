# Observer Pattern
# Date: 02-Mar-2018
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# The source code contained in this file demonstrates how to
# implement the <em>observer pattern</em>.

# A class that models several Twitter instances
class Twitter
  #Followers of the instance
  attr_accessor :followers

  #Creates the instances of Twitter class
  #params: name, followers
  def initialize(name)
    @name = name
    @followers = []
  end

  # follow method will add this instance as an observer/follower of user
  def follow(user)
    user.followers << self
    self
  end

  # tweet method will inform to all followers about this instance tweet
  def tweet(text)
    @followers.each do |follower|
      follower.receive_tweet(@name, text)
    end
  end

  # receive_tweet method prints the name of observer and the tweet text of
  # this instance for each one of its follower.
  def receive_tweet(user, text)
    puts "#{@name} received a tweet from #{user}: #{text}"
  end

end