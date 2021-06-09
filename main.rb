# require 'active_support' # for cl_image_tag
# require 'action_view' # for cl_image_tag

# include CloudinaryHelper # for cl_image_tag     

require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require 'pry' if development?
require 'cloudinary'

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

  password = params["password"]
  password_digest = BCrypt::Password.create(password)

  sql = "insert into users (user_name, email, password_digest, user_img) values ($1, $2, $3, $4)"
  run_sql(sql, [
    params['user_name'],
    params['email'],
    password_digest,
    params['user_img']
])
  redirect '/login'
end

get '/users/:id' do
  id =  params["id"]

  user = grab_response_by_id("users", id)
  tracks = run_sql("SELECT * from tracks where user_id = $1;", [id])
  tips = run_sql("SELECT * from tips where tipper_id = $1;", [id])
 
  erb :show_user, locals: {
    user: user,
    tracks: tracks,
    tips: tips,
    session: session
  }
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
  if logged_in?
    erb :new_track_form
  else 
    invalid_login = "Please log-in or sign-up to share tracks"
    erb :login, locals: { 
    invalid_login: invalid_login,
    session: session
  }
  end
end

audio_options = {
    cloud_name: "ryanhunterdev",
    api_key: ENV['CLOUDINARY_API_KEY'],
    api_secret: ENV['CLOUDINARY_API_SECRET'],
    resource_type: "video"
}

image_options = {
    cloud_name: "ryanhunterdev",
    api_key: ENV['CLOUDINARY_API_KEY'],
    api_secret: ENV['CLOUDINARY_API_SECRET'],
}

post '/tracks' do
  redirect '/login' unless logged_in?
  audio_res = Cloudinary::Uploader.upload(params['track_audio']['tempfile'], audio_options)
  image_res = Cloudinary::Uploader.upload(params['track_artwork']['tempfile'], image_options)
  # binding.pry
  sql = "INSERT INTO tracks (user_id, track_audio, track_name, track_img, track_info, purchase_link, genre) VALUES ($1, $2, $3, $4, $5, $6, $7);"
  run_sql(sql, [
    params["user_id"],
    audio_res["url"],
    params["track_name"],
    image_res["url"],
    params["track_info"],
    params["purchase_link"],
    params["genre"]
  ])
  redirect "/users/#{session[:user_id]}"
end

get '/tracks/:id' do

  id =  params["id"]
  track = grab_response_by_id("tracks", id)

  publisher = grab_response_by_id("users", track["user_id"])

  tips = run_sql("SELECT * from tips where track_id = $1;", [id])

  erb :show_track, locals: { 
    track: track,
    publisher: publisher,
    session: session,
    tips: tips
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
    sql = "INSERT INTO tips (track_id, track_name, tipper_id, tipper_name, tip_amount, track_publisher_id, track_publisher_name, tip_comment) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);"
    run_sql(sql, [
      params['track_id'],
      params['track_name'],
      params['tipper_id'],
      params['tipper_name'],
      params['tip_amount'],
      params['track_publisher_id'],
      params['track_publisher_name'],
      params['tip_comment']
    ])
  else 
    sql = "INSERT INTO tips (track_id, track_name, tip_amount, track_publisher_id, track_publisher_name) VALUES ($1, $2, $3, $4, $5);"
    run_sql(sql, [
    params['track_id'],
    params['track_name'],
    params['tip_amount'],
    params['track_publisher_id'],
    params['track_publisher_name']
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
    session[:user_name] = logged_in_user["user_name"]
    redirect "/users/#{session[:user_id]}"
  else
    invalid_login = "Invalid username or password. Please try again"
    erb :login, locals: { invalid_login: invalid_login }
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect back
end
