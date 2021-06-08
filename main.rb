     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'

require_relative 'db/helpers.rb'

get '/' do
  erb :index
end

########################

# user routes

########################

get '/users/new' do
  erb :new_user_form
end

post '/users' do
  redirect '/users/:id'
end

get '/users/:id' do
  erb :show_user
end

get '/users/:id/edit' do
  erb :edit_user_form
end

put '/users/:id' do
  redirect '/users/:id'
end

delete '/users/:id' do
  redirect '/'
end

########################

# track routes

########################

get '/tracks/new' do
  erb :new_track_form
end

post '/tracks' do
  redirect '/users/:id'
end

get 'tracks/:id' do
  erb :show_track
end

get 'tracks/:id/edit' do
  erb :edit_track_form
end

put 'tracks/:id' do
  redirect 'tracks/:id'
end

delete 'tracks/:id' do
  redirect '/user/:id'
end

########################

# tip routes

########################

post '/tips' do 
  redirect 'tracks/:id'
end


########################

# session routes

########################

get '/login' do
  erb :login
end

post '/session' do
  redirect '/'
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end
