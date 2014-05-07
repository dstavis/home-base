get '/' do
	unless authenticated?
		redirect '/auths/new'
	else
		erb :index
	end
end