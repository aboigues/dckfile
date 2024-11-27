# Étape 1 : Choisir une image de base
FROM python:3.12-slim

# Étape 2 : Déclarer une variable d’argument
ARG APP_VERSION=1.0

# Étape 3 : Ajouter des métadonnées à l'image
LABEL maintainer="jean-boit-pas@flask.com"
LABEL version=$APP_VERSION
LABEL description="Image fonctionnelle avec une application Flask."

# Étape 4 : Définir des variables d'environnement
ENV APP_HOME=/app
ENV PORT=9090 

# Étape 5 : Définir le répertoire de travail
WORKDIR $APP_HOME

# Étape 6 : Copier les fichiers locaux dans l'image
COPY . .

# Étape 7 : Ajouter un fichier externe via une URL (fonctionnalité ADD)
ADD https://raw.githubusercontent.com/docker/docker.github.io/main/LICENSE /app/LICENSE

# Étape 8 : Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y curl && \
    pip install --no-cache-dir flask && \
    apt-get clean

# Étape 9 : Exposer le port sur lequel l'application écoutera
EXPOSE $PORT

# Étape 10 : Définir le signal d'arrêt pour le conteneur
STOPSIGNAL SIGINT

# Étape 11 : Configurer un volume pour persister les données
VOLUME /data

# Étape 12 : Ajouter une vérification d'état
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:$PORT/health || exit 1

# Étape 13 : Redéfinir le shell pour exécuter les commandes
SHELL ["/bin/bash", "-c"]

# Étape 14 : Définir la commande par défaut (écrasable par des arguments à `docker run`)
CMD ["python", "app.py"]


