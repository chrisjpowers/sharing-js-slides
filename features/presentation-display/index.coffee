fs = require "fs"
feat = require "feat"
nowjs = require "now"
assetPackage = require "../asset-package"
express = require "express"
exports.server = server = express.createServer()
currentId = null

everyone = global.everyone

server.configure ->
  server.set 'view engine', 'jade'
  server.set "views",  "#{__dirname}/views"
  server.use express.static("#{__dirname}/public")

# server.get "/", (req, res) ->
#   fs.readFile "#{__dirname}/../../preso.json", (err, data) ->
#     if err then console.log "ERROR", err
#     locals = JSON.parse data
#     locals.layout = false
#     res.render "index.jade", locals

everyone.now.updateSlide = (secret, id) ->
  if secret == "woot"
    currentId = id
    everyone.now.goto currentId

everyone.now.getCurrentId = (cb) ->
  cb(currentId)

feat.on "presentation-display:on", ->
  assetPackage.include "#{__dirname}/public/js/*.js"
  assetPackage.include "#{__dirname}/public/js/*.coffee"

feat.on "presentation-display:off", ->

