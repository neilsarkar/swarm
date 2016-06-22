var express = require('express');
var app     = express();

var port    = process.env.NODE_APP_PORT || 3000;

var shortid = require('shortid').generate();

app.get('/', function(req, res) {
  res.json({id: shortid, cool: 'nice'})
})

app.listen(port, function() {
  console.log("Listening on port", port)
})
