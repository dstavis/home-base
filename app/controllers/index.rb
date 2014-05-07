get '/' do
	unless authenticated?
		redirect '/auths/new'
	else
		@user = current_user
		redirect "/groups/#{current_user.group.id}"
	end
end