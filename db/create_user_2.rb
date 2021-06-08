require 'bcrypt'
require_relative 'helpers.rb'

username = "turner_st_sound"

password = "pudding"

email = "turnerstsound@gmail.com"

profile_img = "https://f4.bcbits.com/img/a3501688195_10.jpg"

user_bio = "Midnight T + RAS"

user_link = "https://buttersessions.bandcamp.com/album/bunsens-vol-1"

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
