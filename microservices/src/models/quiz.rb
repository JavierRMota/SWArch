# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: quiz.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'faraday'
require 'faraday_middleware'
require 'json'
require './models/quiz_exception'

# The +Quiz+ class is an implementation of the {Singleton
# Pattern}[https://en.wikipedia.org/wiki/singleton_pattern].
# It allows you to create only one instance of itself.
# It represents the object that knows how to call the
# quiz API
class Quiz

    #Singleton instance initialized as nil
    @@instance = nil

    # SCORE endpoint constant
    SCORE = 'scores'
    # Evaluator endpoint constant
    EVALUATOR = 'evaluator'
    # Question endpoint constant
    QUESTION = 'question'

    # Makes get_quiz private to avoid unauthorized access
    private_instance_methods :get_quiz
    # Makes save_score private to avoid unauthorized access
    private_instance_methods :save_score

    # Initialize method
    # Parameters: base_url and api_key
    # Raises Exception if there exists an instance of the class
    def initialize(base_url:, api_key:)
        raise 'Cannot have two Quiz instances' if !@@instance.nil?
        @connection = Faraday.new(
            url: base_url,
            headers: {
                'Content-Type' => 'application/json',
                'x-api-key' => api_key
            }
        ) do |faraday|
            faraday.adapter Faraday.default_adapter
            faraday.response :json
        end
        @@instance = self
    end

    # Create quiz method
    # Parameters: name and questions
    # Creates a quiz for the user with the number of questions given
    def create_quiz(name, questions)
        quizPost = @connection.post(Quiz::SCORE) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { name: name, questions: questions.to_i }.to_json
        end

        raise QuizException.new("Failed to create quiz, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if quizPost.status != 201
        quizPost.body
    end

    # Returns the body of the response of the API Call
    # to get an specific quiz.
    # Raises QuizException if the status is not 200
    def get_quiz(name,id)
        quizResp = @connection.get("#{Quiz::SCORE}?quiz=#{id}&name=#{name}")
        raise QuizException.new("Failed to get quiz, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if quizResp.status != 200
        quizResp.body

    end

    # Returns the body of the response of the API Call
    # to get an specific question.
    # Raises QuizException if the status is not 200
    def get_question(question)
        questionResp = @connection.get("#{Quiz::QUESTION}?id=#{question}")
        raise QuizException.new("Failed to get question, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if questionResp.status != 200
        questionResp.body

    end

    # Returns the next question as a
    # JSON object.
    # Raises QuizEndedException if there are no more question
    def get_next_question(name,id)
        quiz = self.get_quiz(name,id)
        questions = quiz["questions"]
        raise QuizEndedException.new("The quiz has no more questions") if questions.length === 0
        question = self.get_question(questions.pop())
        question["score"] = quiz["score"]
        question

    end

    # Returns the result of the evaluation
    # of a given question.
    # Calls method save_score to update progress.
    # Raises QuizException if the status is not 200
    def evaluate(name, quizId, questionId, answer)
        evaluatorReq = @connection.post(Quiz::EVALUATOR) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { id: questionId, answer: answer }.to_json
        end
        raise QuizException.new("Failed to evaluate question, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if evaluatorReq.status != 200
        evaluation = evaluatorReq.body
        score = self.save_score(name, quizId, questionId, evaluation["correct"])
        evaluation["score"] = score["score"]
        evaluation["end"] = score["questions"].length == 0
        evaluation

    end

    # Returns the body of the response of the API Call
    # to update the progress of a specific quiz.
    # Raises QuizException if the status is not 202
    def save_score(name,quizId,questionId,correct)
        scorePut = @connection.put(Quiz::SCORE) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { name: name, time: quizId, question: questionId.to_i, answer: correct }.to_json
        end

        raise QuizException.new("Failed to update score, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if scorePut.status != 202
        scorePut.body
    end

    # Returns the body of the response of the API Call
    # to get all scores.
    # Raises QuizException if the status is not 200
    def get_scores
        score = @connection.get(Quiz::SCORE)
        raise QuizException.new("Failed to get score, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if score.status != 200
        score.body.to_a.sort { |a, b| b['score'] <=> a['score'] }
    end

    # Returns the score of a given user and quiz
    # Raises QuizException if the quiz is not found.
    def get_score(scores, name, quizId)
        found = nil
        scores.each do |score|
            if (name == score['name'] && quizId == score['id'])
                found = score['score']
                break
            end
        end
        raise QuizException.new("Score not found") if found.nil?
        found
    end

end