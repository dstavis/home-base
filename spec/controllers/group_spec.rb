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
    get "/groups/new", params, fake_session

    ## Assert
    expect(last_response.body).to include("#{@user.first_name}")
  end

end

describe "get /groups/:id route" do
  it "sends user to group page" do
    ## Arrange
    User.destroy_all
    Group.destroy_all
    @group = Group.create(name: "Cool Group")
    @user = User.create(email: "david@stavis.com",
                        first_name: "David",
                        picture_url: "lasturlwastoolong.com",
                        facebook_id: 1,
                        group_id: @group.id)
    fake_session = { 'rack.session' => { user_id: @user.id } }
    params = { id: @group.id }

    ## Act
    get "/groups/#{@group.id}", params, fake_session

    ## Assert
    expect(last_response.body).to include("#{@group.name}")
  end

  it "includes the current user's picture on group page" do
    ## Arrange
    User.destroy_all
    Group.destroy_all
    @group = Group.create(name: "Cool Group")
    @user = User.create(email: "david@stavis.com",
                        first_name: "David",
                        picture_url: "lasturlwastoolong.com",
                        facebook_id: 1,
                        group_id: @group.id)
    fake_session = { 'rack.session' => { user_id: @user.id } }
    params = { id: @group.id }

    ## Act
    get "/groups/#{@group.id}", params, fake_session

    ## Assert
    expect(last_response.body).to include("#{@user.picture_url}")
  end
end

