// Note: You must restart bin/webpack-dev-server for changes to take effect
module.exports = require('./development.js');
const merge = require('webpack-merge')
const sharedConfig = require('./shared.js')

module.exports = merge(sharedConfig, {})
