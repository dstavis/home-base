get '/auths/new' do
	erb :login
end

post '/auths' do
	if user = User.find_by_email(params['email'])
	else
		user = User.create(params)
	end
	session[:user_id] = user.id
	content_type :json
	return user.to_json
end