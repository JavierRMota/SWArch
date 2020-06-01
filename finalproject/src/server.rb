require 'sinatra'
require 'json'
require 'faraday'

BASE_URL = 'https://9xaawb1uu2.execute-api.us-east-1.amazonaws.com/default/'
API_KEY = 'NMIAGNqxO5aQUeIKSWYod7TDzgowKqa5kUYTLh62'
CONNECTION = Faraday.new(
  url: BASE_URL,
  headers: {
    'Content-Type' => 'application/json',
    'x-api-key' => API_KEY
  }
)

SCORE = 'scores'
EVALUATOR = 'evaluator'
QUESTION = 'question'

def tag tag, text
  "<#{tag}>#{text}</#{tag}>"
end

get '/login' do
  @title = "Login"
  erb :login, :layout => :page
end

get '/score' do
  @title = "Score"
  erb :score, :layout => :page
end

get '/' do
  @title = "Quiz System"
  erb :home, :layout => :page
end

get '/quiz/*/*' do |name, quiz|
  resp = CONNECTION.get("#{SCORE}?quiz=#{quiz}&name=#{name}")
  puts resp.body
  resp.body
end

post '/quiz/*/*' do |name, quiz|
 CONNECTION.post(EVALUATOR,'{"choice": "sake"}',
  "Content-Type" => "application/json")
end