process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const path = require('path')
const chokidar = require('chokidar')

environment.config.devServer.before = (app, server) => {
    chokidar.watch([
        path.join(__dirname, '../../config'),
        path.join(__dirname, '../../app/views')
    ]).on('change', () => server.sockWrite(server.sockets, 'content-changed'))
}


module.exports = environment.toWebpackConfig()
