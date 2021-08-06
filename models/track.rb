
def get_audio_response(audio)

    audio_options = {
    resource_type: "video",
    format: "mp3",
    eager_async: true
    }

    audio_res = Cloudinary::Uploader.upload(audio['tempfile'], audio_options)
end

def create_track(id, name, img, info, link, genre, audio, publisher)

    sql = "insert into tracks (user_id, track_name, track_img, track_info, purchase_link, genre, track_audio, track_publisher_name) values ($1, $2, $3, $4, $5, $6, $7, $8)"

    run_sql(sql, [
        id,
        name,
        img,
        info,
        link,
        genre,
        audio,
        publisher
    ])    
end

def get_tips(id)
    tips = run_sql("SELECT * from tips where track_id = $1;", [id])
end

def update_track(name, genre, info, link, publisher, id)
    sql = "UPDATE tracks SET track_name = $1, genre = $2, track_info = $3, purchase_link = $4, track_publisher_name = $5 WHERE id = $6;"
    run_sql(sql, [name, genre, info, link, publisher, id])
end

def update_audio(url, id)
    sql = "update tracks set track_audio = $1 where id = $2;"
    run_sql(sql, [
      url,
      id
    ])
end

def update_img(url, id)
    sql = "update tracks set track_img = $1 where id = $2;"
    run_sql(sql, [
      url,
      id
    ])
end

def delete_track(id)
    sql_tracks = "delete from tracks where id = $1;"
    sql_tips = "delete from tips where track_id = $1;"
    run_sql(sql_tracks, [
      id
    ])
    run_sql(sql_tips, [
      id
    ])
end

def get_all_tracks
    run_sql("Select * from tracks ORDER BY track_name;")
end