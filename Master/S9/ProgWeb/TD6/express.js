var express = require('express');

var app = express();

/*app.get('/', function(req, res) {
    res.setHeader('Content-Type', 'text/plain');
    res.end('Root');
    });*/

var morgan = require('morgan'); // Middleware de logging

app.use(morgan('combined')) 
.get('/', function(req, res) {
  //res.setHeader('Content-Type', 'text/plain');
  res.end('Root');
})
.listen(8080);


app.get('/home', function(req, res) {
    res.setHeader('Content-Type', 'text/plain');
    res.end('Home ...');
});

app.get('/user/:uid', function(req, res) {
    res.setHeader('Content-Type', 'text/plain');
    res.end('Bonjour utilisateur ' + req.params.uid);
});

app.get('/user', function(req,res) {
    let ejs = require('ejs');
    let people = ['geddy', 'neil', 'alex'];
    html = ejs.render('<%= people.join(", "); %>', {people: people});
    //res.setHeader('Content-Type', 'text/html');
    res.end('Bonjour utilisateur ' + html);
    console.log(html);
});

app.use(function(req, res, next){
    res.setHeader('Content-Type', 'text/plain');
    res.status(404).send('Page introuvable !');
});

//app.listen(8080);
