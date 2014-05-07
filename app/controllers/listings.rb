post '/listings' do
	@listing = Listing.create(params)
	erb :_listing, layout: false
end