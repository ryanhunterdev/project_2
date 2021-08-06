def user_exists?(user_name)
    user_search = run_sql("select * from users where user_name = $1", [user_name])
    if user_search.count > 0
        true 
    else 
        false 
    end
end

def email_exists?(email)
    user_search = run_sql("select * from users where email = $1", [email])
    if user_search.count > 0
        true 
    else 
        false 
    end
end

def create_user(name, email, password, img)
    sql = "insert into users (user_name, email, password_digest, user_img) values ($1, $2, $3, $4);"
    run_sql(sql, [
        name,
        email,
        password,
        img
    ])
end

def get_tracks(id)
    run_sql("Select * from tracks where user_id = $1 ORDER by id desc;", [id])
end

def total_tips(tips)
    total = 0
    tips.each do |tip|
      total += tip["tip_amount"].to_f
    end
    total
end

def get_tips(id)
    run_sql("SELECT * from tips where track_publisher_id = $1;", [id])
end

def update_user(name, email, password, bio, link, location, id)
    sql = "UPDATE users SET user_name = $1, email = $2, password_digest = $3, user_bio = $4, user_link = $5, user_location = $6 WHERE id = $7;"
    run_sql(sql, [
      name,
      email,
      password,
      bio,
      link,
      location,
      id
  ])
end

def update_user_img(url, id)
    sql = "update users set user_img = $1 where id = $2;"
    run_sql(sql, [
        url,
        id
    ])
end