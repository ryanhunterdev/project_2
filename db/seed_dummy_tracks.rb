require_relative 'helpers.rb'

names1 = "nasty rude calm heavy meditative sleepy hyped exotic".split(' ')
names2 = "beat riddim anthem track movement dub".split(' ')
ids = [1, 2]
genres = "dub downtempo house techno balaeric street-soul boogie disco hard-metal punk hardcore chamber neo-classical choral".split(' ')

10.times do 
    user_id = ids.sample
    track_name = "#{names1.sample} #{names2.sample}"
    track_img = "https://f4.bcbits.com/img/a0432572701_10.jpg"
    genre = genres.sample
    track_info = "A #{names1.sample} #{genre} #{names2.sample}. Hope you dig"
    purchase_link = "https://buttersessions.bandcamp.com/album/digi-modes"
    track_audio = "http://res.cloudinary.com/ryanhunterdev/video/upload/v1623214129/usadb8bdkkaf8rpiwjvu.mp3"

    sql = "insert into tracks (user_id, track_name, track_img, track_info, purchase_link, genre, track_audio) values ($1, $2, $3, $4, $5, $6, $7)"
    run_sql(sql, [
        user_id,
        track_name,
        track_img,
        track_info,
        purchase_link,
        genre,
        track_audio
    ])

end