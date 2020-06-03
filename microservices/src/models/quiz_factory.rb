require './models/quiz'
class QuizFactory
    @@instance = nil
    def self.get_instance
        raise 'Instance does not exist' if @@instance.nil?
        @@instance
    end
    def self.create
        @@instance = Quiz.new(
            base_url: 'https://9xaawb1uu2.execute-api.us-east-1.amazonaws.com/default/',
            api_key: 'NMIAGNqxO5aQUeIKSWYod7TDzgowKqa5kUYTLh62'
        )
        @@instance
    end
end