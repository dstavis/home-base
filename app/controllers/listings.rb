post '/listings' do
	Listing.create(params)
	erb :_listing
end