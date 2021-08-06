get '/login' do
    invalid_login = ""
    erb :'sessions/new', locals: { invalid_login: invalid_login }
end
  
post '/session' do
    email = params['email'].downcase
    records = run_sql("select * from users where email = $1", [email])
  
    if records.count > 0 && BCrypt::Password.new(records[0]['password_digest']) == params['password']
      logged_in_user = records[0]
      session[:user_id] = logged_in_user["id"]
      session[:user_name] = logged_in_user["user_name"]
      redirect "/users/#{session[:user_id]}"
    else
      invalid_login = "Invalid username or password. Please try again"
      erb :'sessions/new', locals: { invalid_login: invalid_login }
    end
end
  
delete '/session' do
    session[:user_id] = nil
    redirect back
end