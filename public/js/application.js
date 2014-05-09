$(document).ready(function () {

    window.fbAsyncInit = function () {
        
        var environmentVarRequest = $.ajax({
            url: '/env',
            type: 'get'
        })

        environmentVarRequest.done(function(response){
            var ENV = {fb_app_id: Number(response['fb_app_id']), fb_channel_url: response['fb_channel_url']}
            
            FB.init({
                appId: ENV['fb_app_id'], //Heroku: 679243185473224 Development: 839142646102346
                channelUrl: ENV['fb_channel_url'],//http://localhost:9393   //http://home-base-app.herokuapp.com', // Channel File
                cookie: true, // enable cookies to allow the server to access the session
                xfbml: true // parse XFBML
            });

            bindListeners();  
        })
    };

    // Load the SDK Asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk',
            ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement('script');
        js.id = id;
        js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    }(document));

});

var addFBListener = function () {
    FB.Event.subscribe('auth.login', function (response) {
        if (response.status === 'connected') {
            getUserData(response);
        } else if (response.status === 'not_authorized') {
            FB.login(function(){}, {
                scope: 'email'
            });
        } else {
            FB.login(function(){}, {
                scope: 'email'
            });
        }
    });
};

var addListingSubmitListener = function(){
    $('.container').on('submit', "#add-listing", addListing)
}

var addInviteListener = function(){
    $('.container').on('click', '#invite', sendInvite)
}

var bindListeners = function(){
    addFBListener()
    addListingSubmitListener()
    addInviteListener()
}


var getUserData = function (response) {
    console.log("Successfully authenticated. Now creating user data.")

    FB.api('/me?fields=email, picture, first_name', function (response) {
            var userData = {
            email: response.email,
            facebook_id: response.id,
            picture_url: response.picture.data.url,
            first_name: response.first_name
        };
        console.log("Successfully created user data. Now logging in.")
        loginOrCreateUser(userData);
    });
};

var loginOrCreateUser = function(userData){
	console.log("Beginning ajax")
	console.log(userData)
    $.ajax({
        url: '/auths',
        method: 'post',
        data: userData
    }).done(function (response) {
        window.location.href = '/groups/new';
    });
}

var addListing = function(event){
    event.preventDefault()
    var listingRequest = $.ajax({
        url: this.action,
        method: this.method,
        data: $(this).serialize()
    })

    listingRequest.done(appendListing)
}

var appendListing = function(response){
    $('#listings .deck').prepend(response)
}

var sendInvite = function () {
    var groupNumber = window.location.pathname.split('/').pop()
    var groupURL = "http://home-base-app.herokuapp.com/join?group=" + groupNumber

    FB.ui({
        method: 'send',
        link: groupURL
    })
}