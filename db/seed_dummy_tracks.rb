require_relative 'helpers.rb'

names1 = "nasty rude calm heavy meditative sleepy hyped exotic intense phased soothing".split(' ')
names2 = "beat riddim anthem track movement mood feeling explosion aura".split(' ')
ids = [1, 2]
publisher_names = "midnight_t turner_st_sound".split(' ')
genres = "dub downtempo house techno balaeric street-soul boogie disco hard-metal punk hardcore chamber neo-classical choral".split(' ')



10.times do 
    random_num = rand() * 2
    random_index = random_num.floor
    user_id = ids[random_index]
    track_publisher_name = publisher_names[random_index]
    track_name = "#{names1.sample} #{names2.sample}"
    track_img = "https://f4.bcbits.com/img/a0432572701_10.jpg"
    genre = genres.sample
    track_info = "A #{names1.sample} #{genre} #{names2.sample}. Hope you dig"
    purchase_link = "https://buttersessions.bandcamp.com/album/digi-modes"
    track_audio = "http://res.cloudinary.com/ryanhunterdev/video/upload/v1623214129/usadb8bdkkaf8rpiwjvu.mp3"

    sql = "insert into tracks (user_id, track_name, track_img, track_info, purchase_link, genre, track_audio, track_publisher_name) values ($1, $2, $3, $4, $5, $6, $7, $8)"
    run_sql(sql, [
        user_id,
        track_name,
        track_img,
        track_info,
        purchase_link,
        genre,
        track_audio,
        track_publisher_name
    ])

end