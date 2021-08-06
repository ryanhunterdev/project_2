require 'pg'

def run_sql(sql, params = []) 
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'buskr'})
    res = db.exec_params(sql, params)
    db.close
    return res
end          

def grab_response_by_id(table, id)
    res = run_sql("SELECT * from #{table} where id = $1;", [id])
    return res[0]
end

def get_image_response(image)
    image_options = {
    width: 500,
    height: 500,
    crop: "fill"
    }
    image_res = Cloudinary::Uploader.upload(image['tempfile'], image_options)
end


