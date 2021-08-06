require_relative '../models/tip'

post '/tips' do 
  if logged_in?
 
    add_user_tip(
      params['track_id'],
      params['track_name'],
      params['tipper_id'],
      params['tipper_name'],
      params['tip_amount'],
      params['track_publisher_id'],
      params['track_publisher_name'],
      params['tip_comment']
    )
  else 
    add_anonymous_tip(
      params['track_id'],
      params['track_name'],
      params['tip_amount'],
      params['track_publisher_id'],
      params['track_publisher_name']
    )
  end
  redirect "tracks/#{params['track_id']}"
end