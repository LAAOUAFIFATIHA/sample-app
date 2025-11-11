#!/bin/bash

docker stop samplerunning 2>/dev/null || true
docker rm samplerunning 2>/dev/null || true

# Nettoyer les anciens dossiers
rm -rf tempdir

# Créer la structure
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copier les fichiers
cp app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/ 2>/dev/null || true

# Créer le Dockerfile
cat > tempdir/Dockerfile << EOF
FROM python
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/app.py
EOF

cd tempdir

# Utiliser Docker avec le chemin complet
docker build -t sampleapp .
docker run -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a