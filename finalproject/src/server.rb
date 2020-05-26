require 'sinatra'
def tag tag, text
  "<#{tag}>#{text}</#{tag}>"
end
get '/login' do
  @title = "Inicio de sesion"
  erb :login, :layout => :page
end
