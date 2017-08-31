module.exports = function(casper, scenario, vp) {
    casper.click('#header-menu > ul > li:nth-child(1)');
    casper.wait(100);
}
