get '/' do
	unless authenticated?
		redirect '/auths/new'
	else
		@user = current_user
		redirect "/groups/#{current_user.group.id}"
	end
end

get '/env' do
  environmentObject = {fb_app_id: ENV['fb_app_id'], fb_channel_url: ENV['fb_channel_url']}
  content_type :json
  return environmentObject.to_json
end