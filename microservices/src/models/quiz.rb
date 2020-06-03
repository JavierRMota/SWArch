# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: quiz.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'faraday'
require 'faraday_middleware'
require 'json'
require './models/quiz_exception'

class Quiz

    @@instance = nil

    SCORE = 'scores'
    EVALUATOR = 'evaluator'
    QUESTION = 'question'

    private_instance_methods :get_quiz

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

    def get_quiz(name,id)
        quizResp = @connection.get("#{Quiz::SCORE}?quiz=#{id}&name=#{name}")
        raise QuizException.new("Falied to get quiz, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if quizResp.status != 200
        quizResp.body

    end

    def get_question(question)
        questionResp = @connection.get("#{Quiz::QUESTION}?id=#{question}")
        raise QuizException.new("Falied to get question, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if questionResp.status != 200
        questionResp.body

    end

    def get_next_question(name,id)
        quiz = self.get_quiz(name,id)
        questions = quiz["questions"]
        raise QuizEndedException.new("The quiz has no more questions") if questions.length === 0
        question = self.get_question(questions.pop())
        question["score"] = quiz["score"]
        question

    end

    def evaluate(name, quizId, questionId, answer)
        evaluatorReq = @connection.post(Quiz::EVALUATOR) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { id: questionId, answer: answer }.to_json
        end
        raise QuizException.new("Falied to evaluate question, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if evaluatorReq.status != 200
        evaluation = evaluatorReq.body
        score = self.save_score(name, quizId, questionId, evaluation["correct"])
        evaluation["score"] = score["score"]
        evaluation["end"] = score["questions"].length == 0
        evaluation

    end

    def save_score(name,quizId,questionId,correct)
        scorePut = @connection.put(Quiz::SCORE) do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { name: name, time: quizId, question: questionId.to_i, answer: correct }.to_json
        end
    
        raise QuizException.new("Falied to update score, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if scorePut.status != 202
        scorePut.body
    end

    def get_score
        score = @connection.get(SCORE)
        raise QuizException.new("Falied to get score, API responded with status #{quizResp.status} and error #{quizResp.body["error"]}") if score.status != 200
        score.body
    end

end