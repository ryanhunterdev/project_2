require_relative '../models/track.rb'

get '/tracks/new' do
    if logged_in?
      erb :'/tracks/new'
    else 
      invalid_login = "Please log-in or sign-up to share tracks"
      erb :'sessions/new', locals: { 
      invalid_login: invalid_login,
      session: session
    }
    end
end
  
post '/tracks' do
  redirect '/login' unless logged_in?

  audio_res = get_audio_response(params['track_audio'])
  image_res = get_image_response(params['track_img'])

  create_track(
    params["user_id"], 
    params["track_name"], 
    image_res["url"], 
    params["track_info"], 
    params["purchase_link"], 
    params["genre"], 
    audio_res["url"], 
    params["track_publisher_name"]
  )

    redirect "/users/#{session[:user_id]}"
end
  
get '/tracks/:id' do
  
    id =  params["id"]
    track = grab_response_by_id("tracks", id)
  
    publisher = grab_response_by_id("users", track["user_id"])
  
    tips = get_tips(id)
  
    erb :'tracks/track', locals: { 
      track: track,
      publisher: publisher,
      session: session,
      tips: tips
    }
end
  
get '/tracks/:id/edit' do
    current_user = session[:user_id]
    track = grab_response_by_id("tracks", params["id"])
  
    redirect '/login' unless logged_in?
    redirect "/tracks/#{params["id"]}" unless current_user == track["user_id"]
  
  
    erb :'/tracks/edit', locals: {
      track: track
    }
end
  
put '/tracks/:id' do
  redirect '/login' unless logged_in?

  update_track(
    params["track_name"], 
    params["genre"], 
    params["track_info"], 
    params["purchase_link"], 
    params["track_publisher_name"], 
    params["id"]
  )

  redirect "tracks/#{params["id"]}"
end

put '/audio/:id' do
  audio_res = get_audio_response(params['track_audio'])
  
  update_audio(audio_res["url"], params["id"])

  redirect "tracks/#{params["id"]}"
end
  
put '/track_img/:id' do
  image_res = get_image_response(params['track_img'])

  update_img(image_res["url"], params["id"])

  redirect "tracks/#{params["id"]}"
end
  
delete '/tracks/:id' do
  delete_track(params["id"])
  redirect "/users/#{session[:user_id]}"
end
  
get '/tracks' do
    tracks = get_all_tracks()
    erb :'tracks/tracks', locals: {
      tracks: tracks
    }
end