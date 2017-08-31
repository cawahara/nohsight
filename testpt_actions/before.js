var cas = require('casper').create();

cas.start('http://localhost:3000');

cas.then(function(){
   this.echo('First Page is ' + this.getTitle());
})
