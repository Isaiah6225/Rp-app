const express = require('express');
const path = require('path');
const app = express();

// Serve the static files from the Angular build directory
app.use(express.static(path.join(__dirname, '/dist/browser')));

// Send all requests to index.html
app.get('/*', function (req, res) {
  res.sendFile(path.join(__dirname, '/dist/browser', 'index.html'));
});

// Set the port and start the server
const port = process.env.PORT || 8080;
app.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on http://0.0.0.0:${port}`);
});