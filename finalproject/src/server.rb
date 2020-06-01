require 'sinatra'
require 'json'
require 'faraday'
require 'faraday_middleware'

BASE_URL = 'https://9xaawb1uu2.execute-api.us-east-1.amazonaws.com/default/'
API_KEY = 'NMIAGNqxO5aQUeIKSWYod7TDzgowKqa5kUYTLh62'
CONNECTION = Faraday.new(
  url: BASE_URL,
  headers: {
    'Content-Type' => 'application/json',
    'x-api-key' => API_KEY
  }
) do |faraday|
  faraday.adapter Faraday.default_adapter
  faraday.response :json
end

SCORE = 'scores'
EVALUATOR = 'evaluator'
QUESTION = 'question'

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
  resp = CONNECTION.get(SCORE)
  @scores = resp.body
  puts @scores
  erb :score, :layout => :page
end

get '/' do
  @title = "Quiz System"
  erb :home, :layout => :page
end

get '/quiz/*/*' do |name, quiz|
  resp = CONNECTION.get("#{SCORE}?quiz=#{quiz}&name=#{name}")
  quizBody = resp.body
  question = quizBody["questions"].pop()
  questionResp = CONNECTION.get("#{QUESTION}?id=#{question}")
  @id = questionResp.body["id"]
  @score = quizBody["score"]
  @question = questionResp.body["question"]
  @A = questionResp.body["A"]
  @B = questionResp.body["B"]
  @C = questionResp.body["C"]
  @D = questionResp.body["D"]
  @name = name
  @quiz = quiz
  erb :question, :layout => :page
end

post '/quiz/*/*' do |name, quiz|
  postResp = CONNECTION.post(EVALUATOR) do |req|
    req.headers['Content-Type'] = 'application/json'
    req.body = { id: params['id'], answer: params['answer'] }.to_json
  end
  if postResp.status === 200
    @question = params['question']
    @answer = params['answer']
    @correct = postResp.body['correct']
    
    @name = name
    @quiz = quiz
    @correctAnswer = postResp.body['answer']
    scorePut = CONNECTION.put(SCORE) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { name: name, time: quiz, question: params['id'].to_i, answer: @correct }.to_json
    end
    @score = scorePut.body["score"]
    erb :solution, :layout => :page
  else
    erb :error, :layout => :page
  end
end