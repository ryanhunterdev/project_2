def logged_in? 
    !!session[:user_id] 
end
  
def current_user 
    if logged_in?
      return run_sql("SELECT * from users where id = #{session[:user_id]};")[0]
    end
end