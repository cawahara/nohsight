module.exports = function(casper, scenario, vp) {
   casper.fill('form#login-form', {
      'session[email]':    'example@gmail.com',
      'session[password]': 'password'
   }, true);
   

   casper.waitForUrl("http://localhost:3000/", function(){
      casper.click('#header-menu > ul > li:nth-child(1)');
      casper.wait(250);
   });

}
