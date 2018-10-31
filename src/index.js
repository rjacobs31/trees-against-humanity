'use strict'

// Require index.html so it gets copied to dist
require('./index.html')
require('./styles/app.css')

const Elm = require('./Main.elm')
const mountNode = document.getElementById('main')

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
const app = Elm.Elm.Main.init(mountNode)
