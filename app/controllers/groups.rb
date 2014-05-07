get '/groups/new' do
	@user = current_user
	if !@user.group
		erb :group_creation
	else
		redirect "/groups/#{@user.group.id}"
	end
end

post '/groups' do
	user = current_user
	user.group = Group.create(params)
	user.save
	redirect "/groups/#{user.group.id}"
end

get '/groups/:id' do
	@group = Group.find(params[:id])
	@user = current_user
	erb :group_page
end

get '/join' do
	session[:join_group_id] = params[:group]
	#flash[:notice] = "Congratulations on your momentous invitation! Sign up and you will automatically join your friend's hunting party."
	redirect '/auths/new'
end