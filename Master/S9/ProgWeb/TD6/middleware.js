var morgan = require('morgan'); // Middleware de logging

app.use(morgan('combined'))
.get('/', function(req, res) {
  res.setHeader('Content-Type', 'text/plain');
  res.end('Root');
})
.listen(8080);
