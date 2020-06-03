# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: server.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'sinatra'
require 'json'
require './models/quiz_factory'
require './models/quiz_exception'

QUIZ = QuizFactory.create

def tag tag, text
  "<#{tag}>#{text}</#{tag}>"
end

get '/login' do
  @title = "Login"
  @name = "login"
  erb :login, :layout => :page
end

get '/score' do
  @title = "Score"
  @name = "score"
  @scores = QUIZ.get_score
  erb :score, :layout => :page
end

get '/' do
  @title = "Quiz Application with Microservices"
  erb :home, :layout => :page
end

get '/continue' do
  @title = "Continue Quiz"
  erb :continue, :layout => :page
end

post '/continue' do
  redirect "quiz/#{params["name"]}/#{params["quizId"]}"
end

get '/quiz/*/*' do |name, quizId|
  begin
    question = QUIZ.get_next_question(name,quizId)
    @questionId = question["id"]
    @score = question["score"]
    @question = question["question"]
    @A = question["A"]
    @B = question["B"]
    @C = question["C"]
    @D = question["D"]
    @name = name
    @quizId = quizId
    erb :question, :layout => :page
  rescue QuizEndedException => e
    redirect '/score'
  rescue QuizException => e
    @error = e.to_s
    erb :error, :layout => :page
  end
end

post '/quiz/*/*' do |name, quizId|
  begin
    evaluation = QUIZ.evaluate(name, quizId, params['id'], params['answer'])
    @question = params['question']
    @answer = params['answer']
    @correct = evaluation['correct']  
    @name = name
    @quizId = quizId
    @correctAnswer = evaluation['answer']  
    @score = evaluation["score"]
    @end = evaluation["end"]
    erb :solution, :layout => :page
  rescue QuizException => e
    @error = e.to_s
    erb :error, :layout => :page
  end
end


not_found do
  status 404
  @error = "Link not found"
  erb :error, :layout => :page
end