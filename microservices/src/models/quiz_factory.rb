# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: quiz_factory.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require './models/quiz'

# The +QuizFactory+ class is an implementation of the {Simple
# Factory Pattern}[https://en.wikipedia.org/wiki/Factory_method_pattern].
# It allows you to create instances of the ::Quiz class
# by calling the ::create class method.
class QuizFactory
    ## Class instance of the last created factory item
    @@instance = nil

    ## Returns instance created by the QuizFactory
    def self.get_instance
        raise 'Instance does not exist' if @@instance.nil?
        @@instance
    end

    # Returns new instance of ::Quiz class with the correct endpoint and api_key
    def self.create
        @@instance = Quiz.new(
            base_url: 'https://9xaawb1uu2.execute-api.us-east-1.amazonaws.com/default/',
            api_key: 'NMIAGNqxO5aQUeIKSWYod7TDzgowKqa5kUYTLh62'
        )
        @@instance
    end
end