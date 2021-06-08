require 'bcrypt'
require_relative 'helpers.rb'

username = "midnight-t"

password = "pudding"

email = "midnighttenderness1984@gmail.com"

profile_img = "https://crownruler.com/wp-content/uploads/2019/11/Midnight-T_Press-1.jpg"

user_bio = "DJ And producer from Naarm (Melbourne)"

user_link = "https://midnight-t.bandcamp.com/"

password_digest = BCrypt::Password.create(password)

sql = "INSERT INTO users (user_name, password_digest, email, profile_img, user_bio, user_link) values ($1, $2, $3, $4, $5, $6)"

run_sql(sql, [
    username,
    password_digest,
    email,
    profile_img,
    user_bio,
    user_link
])
