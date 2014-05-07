get '/auths/new' do
	erb :login
end

post '/auths' do
	if user = User.find_by_email(params['email'])
		session[:user_id] = user.id
	else
		user = User.create(params)
		session[:user_id] = user.id
	end
end