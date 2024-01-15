docker build -t k8s-microservice:latest ./app
docker run -p 5000:5000 k8s-microservice:latest