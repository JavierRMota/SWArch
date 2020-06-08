# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: server.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'sinatra'
require 'json'
require './models/quiz_factory'
require './models/quiz_exception'

# QUIZ constant using QuizFactory to get the correct API endpoint and key
QUIZ = QuizFactory.create

# Returns a formatted tag in the form <tag class="classes">text</tag>
def tag tag, text, classes = nil
  "<#{tag} #{classes.nil? ? '': "class='#{classes}'"}'>#{text}</#{tag}>"
end

# Renders login view
get '/login' do
  @title = "Login"
  @name = "login"
  erb :login, :layout => :page
end

# Renders score view with score response from API
get '/score' do
  @title = "Score"
  @name = "score"
  @scores = QUIZ.get_scores
  erb :score, :layout => :page
end

# Renders home view
get '/' do
  @title = "Quiz Application with Microservices"
  erb :home, :layout => :page
end

# Starts a new quiz
post '/login' do
  quiz = QUIZ.create_quiz(params["name"], params["questions"])
  redirect "quiz/#{params["name"]}/#{quiz["req_time"]}"
end

# Renders continue quiz view
get '/continue' do
  @title = "Continue Quiz"
  erb :continue, :layout => :page
end

# Redirects to previously generated quiz
post '/continue' do
  redirect "quiz/#{params["name"]}/#{params["quizId"]}"
end

# Loads quiz next question and renders question view
# If a method raises an exception renders the corresponding view
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

# Evaluates an answer and renders the solution view
# If a method raises an exception renders the corresponding view
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

# Sets 404 template
not_found do
  status 404
  @error = "Link not found"
  erb :error, :layout => :page
end