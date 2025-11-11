#!/bin/bash
echo "=== 🐳 DÉPLOIEMENT DOCKER ==="

# Aller dans le dossier
cd /home/fatiha/mon-projet-jenkins/sample-app/tempdir

# Activer l'environnement
source /home/fatiha/my_env/bin/activate

# Arrêter l'ancien conteneur
docker stop samplerunning 2>/dev/null || true
docker rm samplerunning 2>/dev/null || true

# Construire et lancer
docker build -t sampleapp .
docker run -d -p 5050:5050 --name samplerunning sampleapp

# Vérifier
echo "=== ✅ VÉRIFICATION ==="
docker ps | grep sample
curl -s http://localhost:5050 | head -3

echo "🎉 APPLICATION DÉPLOYÉE SUR http://localhost:5050"