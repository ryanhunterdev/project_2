     
require 'sinatra'
require 'sinatra/reloader' #if development?
require 'pg'
require 'bcrypt'

require_relative 'db/helpers.rb'

enable :sessions

def logged_in? 
  !!session[:user_id] 
end

def current_user 
  if logged_in?
    return run_sql("SELECT * from users where id = #{session[:user_id]};")[0]
  end
end

get '/' do
  tracks = run_sql("Select * from tracks")
  erb :index, locals: {
    tracks: tracks
  }
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
  # look up the record by the email address first
  records = run_sql("select * from users where email = $1", [params['email']])
  
  # if there is no such email in the databse, the response array will contain 0 items. next we are using the BCrypt function to reverse an encrypted password. It returns a boolean if there is a match so can be used here in the comaprison

  if records.count > 0 && BCrypt::Password.new(records[0]['password_digest']) == params['password']
    # write it down that you are now logged in
    # session is a global hash for every user
    # single source of truth
    logged_in_user = records[0]
    session[:user_id] = logged_in_user["id"]
    redirect '/'
  else
    # nah
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end
