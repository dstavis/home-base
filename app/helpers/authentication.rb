helpers do
	def authenticated?
		!!session[:user_id]
	end

	def current_user
		return User.find(session[:user_id])
	end
end