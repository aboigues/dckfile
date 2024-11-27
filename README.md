# dckfile

Projet Dockerfile à des fins strictement pédagogiques

Reconstruisez l’image après modification :

```
docker build -t test-dockerfile .
``` 

Lancez le conteneur avec le nouveau port mappé :

```
docker run -d -p 6000:6000 test-dockerfile
```

Vérifiez le conteneur actif :

```
docker ps
```

Testez l'application :

Visitez http://localhost:6000 pour voir le message Hello, Dockerfile!.
Accédez à http://localhost:6000/health pour vérifier l’état de santé.
