require 'bcrypt'
require_relative 'helpers.rb'

username = "turner_st_sound"

password = "pudding"

email = "turnerstsound@gmail.com"

user_img = "https://f4.bcbits.com/img/a3501688195_10.jpg"

user_bio = "The debut EP from Aussie producers Turner Street Sound has finally blossomed! The duo made up of Rory McPike AKA Rings Around Saturn and Ryan Hunter AKA MidnightTenderness first launched the project with 'Stoned Mix' on Domestic Documents Vol. 1 in 2016, shaking bass bins in its path. 'Bunsen Vol. 1' is a collection of tracks recorded between 14'-17' encapsulating the boys influences with the Turner Street twist."

user_link = "https://buttersessions.bandcamp.com/album/bunsens-vol-1"

user_location = "nowhere"

password_digest = BCrypt::Password.create(password)

sql = "INSERT INTO users (user_name, password_digest, email, user_img, user_bio, user_link, user_location) values ($1, $2, $3, $4, $5, $6, $7)"

run_sql(sql, [
    username,
    password_digest,
    email,
    user_img,
    user_bio,
    user_link,
    user_location
])
