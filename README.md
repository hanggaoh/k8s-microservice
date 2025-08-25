# Kubernetes Microservice Deployment

A simple Python Flask microservice deployed on Kubernetes with scaling, health checks, and observability.

## 🚀 Features
- Containerized Python Flask app with a health endpoint.
- Kubernetes Deployment with:
  - Liveness and readiness probes.
  - Resource requests/limits for better scheduling.
- Service (ClusterIP) to expose the app inside the cluster.
- Horizontal Pod Autoscaler (HPA) to scale pods based on CPU usage.
- Prometheus integration for metrics scraping (optional).

## 📂 Project Structure

```
/Users/hang/Documents/GitHub/k8s-microservice/
├───.gitattributes
├───build.sh
├───README.md
├───.git/...
├───app/
│   ├───Dockerfile
│   ├───main.py
│   └───requirements.txt
└───k8s/
    ├───deployment.yaml
    ├───hpa.yaml
    ├───prometheus.yaml
    └───service.yaml
```

## 🛠️ Getting Started

### Prerequisites

- Docker
- Minikube (or any Kubernetes cluster)
- kubectl

### 1. Build and Run the Docker Image

The `build.sh` script will build the Docker image and run it locally.

```bash
sh build.sh
```

You can access the application at `http://localhost:5000`.

### 2. Deploy to Kubernetes

First, make sure your Docker image is available to your Kubernetes cluster. If you are using Minikube, you can build the image directly into the Minikube Docker daemon:

```bash
eval $(minikube docker-env)
docker build -t k8s-microservice:latest ./app
```

Then, apply the Kubernetes manifests:

```bash
kubectl apply -f k8s/
```

This will create the deployment, service, and HPA.

### 3. Access the Service

To access the service from your local machine, you can use `kubectl port-forward`:

```bash
kubectl port-forward svc/k8s-microservice 8080:80
```

Now you can access the application at `http://localhost:8080`.

### 4. Scaling

The Horizontal Pod Autoscaler will automatically scale the number of pods based on CPU usage. You can also manually scale the deployment:

```bash
kubectl scale deployment k8s-microservice --replicas=3
```

### 5. Observability

If you have the Prometheus Operator installed, the `ServiceMonitor` will automatically configure Prometheus to scrape metrics from the application. You will need to add the `prometheus-client` library to the `requirements.txt` and expose a `/metrics` endpoint in `main.py` for this to work.