'use strict';

// Require index.html so it gets copied to dist
require('./index.html');
require('./styles/app.css');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);

var webAuth = new auth0.WebAuth({
  domain: '[AUTH0_DOMAIN]', // e.g., you.auth0.com
  clientID: '[AUTH0_CLIENT_ID]',
  scope: 'email',
  responseType: 'token',
  redirectUri: '[AUTH0_REDIRECT_URI]'
});

app.ports.auth0authorise.subscribe(function(opts) {
  webAuth.authorize();
});

webAuth.parseHash({ hash: window.location.hash }, function(err, authResult) {
  var result = { err: null, ok: null };
  if (err) {
    result.err = err;
  }
  if (authResult) {
    result.ok = {token: authResult.authToken}
  }
  app.ports.auth0authResult.send(result);
});
