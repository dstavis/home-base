get '/auths/new' do
	#login form
	erb :login
end

post '/auths' do
	#log a user in by comparing their userdata to the database- and, if they exist, loading their id into session.
	binding.pry
	#OR, if this user does not have an account yet, create a new user and save their info in the database

end

get '/auths' do
	#return useful object of the currently authenticated user
end