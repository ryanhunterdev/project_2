require 'pg'

def run_sql(sql, params = []) 
   
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'buskr'})
    res = db.exec_params(sql, params)
    db.close
    return res
end          

def logged_in? 
    !!session[:user_id] 
end
  
def current_user 
    if logged_in?
      return run_sql("SELECT * from users where id = #{session[:user_id]};")[0]
    end
end

def grab_response_by_id(table, id)
    res = run_sql("SELECT * from #{table} where id = $1;", [id])
    return res[0]
end