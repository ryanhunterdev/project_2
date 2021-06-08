     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require 'pry' if development?

require_relative 'db/helpers.rb'

enable :sessions

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

get '/tracks/:id' do

  id =  params["id"]
  track = grab_response("tracks", id)

  publisher_id = track["user_id"]
  publisher = grab_response("users", publisher_id)
  # binding.pry
  erb :show_track, locals: { 
    track: track,
    publisher: publisher,
    session: session
  }
end

get '/tracks/:id/edit' do
  erb :edit_track_form
end

put '/tracks/:id' do
  redirect 'tracks/:id'
end

delete '/tracks/:id' do
  redirect '/user/:id'
end

get 'tracks' do
  erb :all_tracks
end

########################

# tip routes

########################

post '/tips' do 
  if logged_in?
    sql = "INSERT INTO tips (track_id, user_id, tip_amount, publisher_id, tip_comment) VALUES ($1, $2, $3, $4, $5);"
    run_sql(sql, [
      params['track_id'],
      params['user_id'],
      params['tip_amount'],
      params['publisher_id'],
      params['tip_comment']
    ])
  else 
    sql = "INSERT INTO tips (track_id, tip_amount, publisher_id) VALUES ($1, $2, $3);"
    run_sql(sql, [
    params['track_id'],
    params['tip_amount'],
    params['publisher_id']
  ])
  end
  redirect "tracks/#{params['track_id']}"
end


########################

# session routes

########################

get '/login' do
  invalid_login = ""
    erb :login, locals: { invalid_login: invalid_login }
end

post '/session' do

  records = run_sql("select * from users where email = $1", [params['email']])

  if records.count > 0 && BCrypt::Password.new(records[0]['password_digest']) == params['password']
    logged_in_user = records[0]
    session[:user_id] = logged_in_user["id"]
    redirect '/'
  else
    invalid_login = "Invalid username or password. Please try again"
    erb :login, locals: { invalid_login: invalid_login }
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end
