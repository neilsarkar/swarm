var express = require('express');
var app = express();

var port = process.env.NODE_APP_PORT || 3000;

app.get('/', function(req, res) {
  res.json({cool: 'nice'})
})

app.listen(port, function() {
  console.log("Listening on port", port)
})
