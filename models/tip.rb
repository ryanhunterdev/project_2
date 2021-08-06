def add_user_tip(id, track_name, tipper_id, tipper_name, amount, publisher_id, publisher_name, comment)
    sql = "INSERT INTO tips (track_id, track_name, tipper_id, tipper_name, tip_amount, track_publisher_id, track_publisher_name, tip_comment) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);"

    run_sql(sql, [
      id,
      track_name,
      tipper_id,
      tipper_name,
      amount,
      publisher_id,
      publisher_name,
      comment
    ])
end

def add_anonymous_tip(track_id, track_name, tip_amount, track_publisher_id, track_publisher_name)
    run_sql(sql, [
        track_id,
        track_name,
        tip_amount,
        track_publisher_id,
        track_publisher_name
    ])
end