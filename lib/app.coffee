feat = require "feat"
express = require "express"
app = express.createServer()

app.use feat.middleware()
app.use feat.gui()

port = process.env.PORT || 8080
app.listen port
console.log "Running on port #{port}"

nowjs = require "now"
global.everyone = nowjs.initialize app
