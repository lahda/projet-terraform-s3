const http = require('http');
const os   = require('os');

const PORT = 8080;

const server = http.createServer((req, res) => {
  // On répond uniquement sur GET /
  if (req.method !== 'GET' || req.url !== '/') {
    res.writeHead(404);
    res.end('Not found');
    return;
  }

  // On lit les variables d'environnement injectées par ECS
  const env      = process.env.ENVIRONNEMENT || 'inconnu';
  const hostname = os.hostname(); // ID du conteneur ECS — change à chaque tâche

  res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
  res.end(`
    <!DOCTYPE html>
    <html>
      <head><title>FilRouge Terraform AWS</title></head>
      <body style="font-family:Arial; text-align:center; padding:60px; background:#1a1a2e; color:#fff;">
        <h1> Fil Rouge Terraform + AWS</h1>
        <h2>Environnement : <span style="color:#7F77DD">${env}</span></h2>
        <p>Conteneur ID : <code>${hostname}</code></p>
        <p>Serveur démarré sur le port ${PORT}</p>
        <p style="color:#639922;">✓ ECS Fargate fonctionne !</p>
      </body>
    </html>
  `);
});

server.listen(PORT, () => {
  console.log(`Serveur démarré sur le port ${PORT}`);
  console.log(`Environnement : ${process.env.ENVIRONNEMENT || 'inconnu'}`);
});