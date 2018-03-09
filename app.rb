require 'sinatra'
require 'sinatra/flash' #gema para poner mensajes flash en sinatra
enable :sessions
def autorized?
   request.cookies["password"] && request.cookies["email"]
end
get '/formulario' do
  erb :formulario
end

post '/formulario' do
  @email = params[:email]
  @password = params[:password]
  File.read("lista.txt")
  arr = IO.readlines("lista.txt")
  arr.each do |i|
    array_persona = i.to_s.chomp.split(",")
    email_actual, pass_actual = array_persona
    if email_actual == @email && pass_actual == @password
      response.set_cookie("email", value: @email)
      response.set_cookie("password", value: @password)
      redirect '/'
    end
  end
  unless autorized?
    flash[:notice] = "Ups, este Usuario aun no esta registrado!"
    redirect '/singup'
  end
end

get '/no_existe' do
  erb :no_existe
end

get '/singup' do
  erb :singup
end

post '/singup' do
  @email = params[:email]
  @password = params[:password]
  response.set_cookie("email", value: @email)
  response.set_cookie("password", value: @password)
  open('lista.txt','a') do |f|
    f << @email + "," + @password + "\n"
  end
  redirect '/'
end


get '/' do
  if autorized?
    erb :home
  else
    redirect '/formulario'
  end
end

get '/contact' do
  if autorized?
    erb :contact
  else
    redirect '/formulario'
  end
end

get '/delete' do
  response.delete_cookie("password")
  response.delete_cookie("email")
  redirect '/formulario'
end
