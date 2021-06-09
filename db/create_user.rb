require 'bcrypt'
require_relative 'helpers.rb'

username = "midnight-t"

password = "pudding"

email = "midnighttenderness1984@gmail.com"

user_img = "https://crownruler.com/wp-content/uploads/2019/11/Midnight-T_Press-1.jpg"

user_bio = "With releases on Australian labels Ken Oath, Outer Time Inner Space, ILIO and Soothsayer, Ryan’s productions merge sparkling digital tones and heavy basslines, rooted in dub, synth funk, broken beat and jungle.


As a DJ, he draws from these versatile foundations, unafraid to shift tempos and explore the connections between seemingly disparate styles. His live performances expand on this approach, whisking party goers from the Paradise Garage to a Jah Shaka dance hall and off to a warehouse rave for sweets.


His collaboration with Rings Around Saturn, dubbed Turner Street Sound, is responsible for the stone-cold and widely revered Bunsens Vol.1 LP on Butter Sessions. He also hosts Heavy As Stone on Skylab radio, a monthly excursion through the bottom-heavy end of dance music."

user_link = "https://midnight-t.bandcamp.com/"

user_location = "Naarm (Melbourne)"

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
