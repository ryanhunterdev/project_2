require_relative '../models/user.rb'

get '/users/new' do
    erb :'users/new', locals: {
      sign_up_alert: ""
    }
end
  
get '/users/new/:alert' do
    new_user_alerts = [
      "username already exists, please choose another",
      "email already registered, please use another"
    ]
    alert_index = params["alert"].to_i 
    erb :'/users/new', locals: {
      sign_up_alert: new_user_alerts[alert_index]
    }
end
  
post '/users' do
  
  password = params["password"]
  email = params["email"].downcase
  password_digest = BCrypt::Password.create(password)
    
  if user_exists?(params["user_name"]) 
    redirect '/users/new/0'
  elsif email_exists?(email)
    redirect '/users/new/1'
  else
    create_user(
      params['user_name'],
      email,
      password_digest,
      params['user_img']
    )
  end
  
  redirect '/login'
end
  
get '/users/:id' do
  id =  params["id"]

  tips = get_tips(params["id"])
  tip_count = total_tips(tips)
  
  erb :'/users/user', locals: {
    user: grab_response_by_id("users", id),
    tracks: get_tracks(id),
    tips: tips, 
    session: session,
    tip_count: tip_count
  }
end
  
get '/users/:id/edit' do
  current_user = session[:user_id]
  redirect '/login' unless logged_in?
  redirect "/users/#{current_user}" unless current_user == params["id"]
  user = grab_response_by_id("users", session[:user_id])
  erb :'/users/edit', locals: {
    user: user
  }
end
  
put '/users/:id' do
  redirect '/login' unless logged_in?
  password = params["password"]
  password_digest = BCrypt::Password.create(password)
  
  update_user(
      params["user_name"],
      params["email"],
      password_digest,
      params["user_bio"],
      params["user_link"],
      params["user_location"],
      session[:user_id]
  )
  redirect "/users/#{session[:user_id]}"
end
  
put '/user_images/:id' do
  redirect '/login' unless logged_in?

  image_res = get_image_response(params['user_img'])

  update_user_img(image_res["url"], params["id"])
  redirect "/users/#{session[:user_id]}"
end
  
delete '/users/:id' do
  redirect '/'
end