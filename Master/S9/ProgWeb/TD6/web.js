var http = require('http');

var server = http.createServer(function(req, res) {
  console.log('Processing request...');
  res.writeHead(200);
  res.end('Salut tout le monde !');
});
server.listen(8080);
