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

def tag tag, text
  "<#{tag}>#{text}</#{tag}>"
end

get '/login' do
  @title = "Inicio de sesion"
  erb :login, :layout => :page
end
