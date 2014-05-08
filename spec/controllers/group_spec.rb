require 'spec_helper'

describe "get /groups/new route" do

  it "sends user to group creation page if no group" do
    ## Arrange
    User.destroy_all
    @user = User.create(email: "david@stavis.com",
                        first_name: "David",
                        picture_url: "lasturlwastoolong.com",
                        facebook_id: 1)
    fake_session = { 'rack.session' => { user_id: @user.id } }
    params = {}

    ## Act
    get '/groups/new', params, fake_session

    ## Assert
    expect(last_response.body).to include("#{@user.first_name}")

  end


end