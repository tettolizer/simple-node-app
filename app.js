// app.js
// A simple "Hello World" web application using the Express framework.

const express = require('express');
const app = express();
const port = 3000;

// Define a route for the root URL ('/')
app.get('/', (req, res) => {
  res.send('Hello World! This is a simple Node.js application.');
});

// Start the server and listen on the specified port
const server = app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

// Export the server object for testing purposes or other integrations
module.exports = server;
