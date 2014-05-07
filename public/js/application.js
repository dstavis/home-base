$(document).ready(function () {

    window.fbAsyncInit = function () {
        FB.init({
            appId: '839142646102346', // App ID
            channelUrl: '//localhost:9393', // Channel File
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true // parse XFBML
        });

        addEventListeners();
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

var addEventListeners = function () {
    FB.Event.subscribe('auth.login', function (response) {
        if (response.status === 'connected') {
            loggedInHandler(response);
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


var loggedInHandler = function (response) {
    console.log("Successfully authenticated. Now creating user data.")

    FB.api('/me?fields=email, picture', function (response) {
        var userData = {
            email: response.email,
            facebook_id: response.id,
            picture_url: response.picture.data.url
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
    	debugger
        // window.location.href = userPage;
    });
}



// AS-YET-UNIMPLEMENTED CODE




// var sendInvite = function () {
//     groupURL = "/join/group/" + current_user().group_id

//     FB.ui({
//         method: 'send',
//         link: groupURL
//     });
// }

// var grabUserpic = function (userID) {
//     FB.api(userID, {
//         fields: 'picture'
//     }, function (response) {
//         picUrl = response.picture.data.url
//         userPic = $("<img src=''>").attr("src", picUrl)
//     })
// }

// var appendUserPic = function (parentNode, userID) {
//     $(parentNode).append(grabUserpic(userID))
// }