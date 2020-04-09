process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const path = require('path')

environment.config.devServer.watchContentBase = true
environment.config.devServer.contentBase = [
    path.join(__dirname, '../../config'),
    path.join(__dirname, '../../app/views')
]


module.exports = environment.toWebpackConfig()
