'use strict'

// Require Auth0 for authentication
const auth0 = require("auth0-lock")
const auth0Options = {
  auth: {
    audience: 'https://tinyscythe.co.za/treesagainsthumanity/',
    responseType: 'token',
  }
}
const lock = new auth0.Auth0Lock('Ab9GsMWoZPvST5bwDBJAYQHOSv0JvFbp', 'tinyscythe.eu.auth0.com', auth0Options)

// Require index.html so it gets copied to dist
require('./index.html')
require('./styles/app.css')

const Elm = require('./Main.elm')
const mountNode = document.getElementById('main')

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
const app = Elm.Main.embed(mountNode)

app.ports.auth0authorise.subscribe(function(opts) {
  lock.show()
})

app.ports.auth0logout.subscribe(function(opts) {
  lock.logout()
})

lock.on('authenticated', authResult => {
  lock.hide()
  const result = { err: null, ok: null };
  if (authResult) {
    result.ok = {token: authResult.accessToken}
  }
  app.ports.auth0authResult.send(result);
})
