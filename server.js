const express = require('express');
const path = require('path');
const http = require('http');
const https = require('https');
const fs = require('fs');

const app = express();
const httpPort = 80; // Puerto HTTP
const httpsPort = 443; // Puerto HTTPS

// Configura el middleware para servir archivos estáticos desde la carpeta 'build'
app.use(express.static(path.join(__dirname, 'build')));

// Ruta para redirigir HTTP a HTTPS
app.use((req, res, next) => {
  if (!req.secure) {
    return res.redirect('https://' + req.headers.host + req.url);
  }
  next();
});

// Ruta para servir el archivo index.html
app.get('/*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

// Lee el contenido de los archivos de clave privada y certificado SSL
const privateKey = fs.readFileSync('/etc/letsencrypt/live/billionsoffice.com/privkey.pem', 'utf8');
const certificate = fs.readFileSync('/etc/letsencrypt/live/billionsoffice.com/fullchain.pem', 'utf8');

// Configura las opciones para el servidor HTTPS
const httpsOptions = {
  key: privateKey,
  cert: certificate,
};

// Crea el servidor HTTP
const httpServer = http.createServer(app);

// Crea el servidor HTTPS
const httpsServer = https.createServer(httpsOptions, app);

// Inicia ambos servidores
httpServer.listen(httpPort, () => {
  console.log(`Servidor HTTP escuchando en el puerto ${httpPort}`);
});

httpsServer.listen(httpsPort, () => {
  console.log(`Servidor HTTPS escuchando en el puerto ${httpsPort}`);
});
