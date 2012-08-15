feat = require "feat"
AirDrop = require "air-drop"
express = require "express"
exports.server = server = express.createServer()

drop = AirDrop("/main.js").include("#{__dirname}/../../public/js/jquery.js")
server.use drop

exports.include = -> drop.include.apply drop, arguments
exports.require = -> drop.require.apply drop, arguments
