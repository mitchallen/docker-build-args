/**
 * Author: Mitch Allen 
 * https://scriptable.com
 * https://mitchallen.com
 */

const express = require('express'),
      uptime = require('@mitchallen/uptime');
const app = express();
const port = 3000;

const APP_NAME = 'docker-build-args';

const DOCKER_TAG = process.env.DOCKER_TAG || '0.0.0-development';


app.get('/', function(req, res) {
  res.json({ 
      status: 'OK', 
      app: APP_NAME, 
      version: DOCKER_TAG, 
      uptime: uptime.toHHMMSS(),
      route: "/",
   });   
});

const server = app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

function signalHandler(signal) {
  console.debug(`\n${signal} signal received: closing HTTP server`)
  server.close(() => {
    console.debug('HTTP server closed'); 
  })
  process.exit();
}

process.on('SIGINT', signalHandler )
process.on('SIGTERM', signalHandler )
