get '/auths/new' do
	erb :login
end

post '/auths' do
	if user = User.find_by_email(params['email'])
	else
		user = User.create(params)
	end

	if session[:join_group_id] && !user.group
		if user.group = Group.find(session[:join_group_id])
			user.save
		else
			#flash[:error] = "Sorry, we can't find a group with that ID! Maybe you got a bad link? Please message us if you think this is an error."
		end
		session[:join_group_id] = nil
	end

	session[:user_id] = user.id

	content_type :json
	return user.to_json
end