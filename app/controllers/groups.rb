get '/groups/new' do
	@user = current_user
	erb :group_creation
end

post '/groups' do
	current_user.group.create(params)
	redirect '/groups/#{current_user.group.id}'
end

get '/groups/:id' do
	@group = Group.find(params[:id])
	erb :group_page
end