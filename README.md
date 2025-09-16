# Python Flask API Application

A simple Flask REST API application with user and product management endpoints, containerized with Docker and deployable on Kubernetes using Helm.

## Features

- RESTful API endpoints for users and products
- Modular architecture with blueprints and services
- Docker containerization with multi-stage build
- Kubernetes deployment with Helm charts
- CI/CD pipeline with GitHub Actions
- Security scanning with Bandit and Trivy
- Code quality checks with Flake8

## API Endpoints

### Users
- `GET /users` - Get all users
- `GET /users/<id>` - Get user by ID

### Products
- `GET /products` - Get all products
- `GET /products/<id>` - Get product by ID

## Project Structure

```
Python-app/
├── app/
│   ├── routes/          # API route definitions
│   ├── services/        # Business logic layer
│   ├── __init__.py      # Flask app factory
│   └── main.py          # Application entry point
├── helm/                # Kubernetes Helm charts
├── .github/workflows/   # CI/CD pipeline
├── Dockerfile           # Container configuration
├── requirements.txt     # Python dependencies
└── run.py              # Application runner
```

## Quick Start

### Local Development

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the application:
```bash
python run.py
```

The API will be available at `http://localhost:5000`

### Docker

1. Build the image:
```bash
docker build -t python-app .
```

2. Run the container:
```bash
docker run -p 5000:5000 python-app
```

### Kubernetes with Helm

1. Install the Helm chart:
```bash
helm install python-app ./helm/python-app
```

## Dependencies

- Flask 2.3.3
- Werkzeug 2.3.7

## CI/CD Pipeline

The GitHub Actions workflow consists of 3 sequential jobs:

### Job 1: build-and-test
- **Triggers**: Changes to workflows, app code, Dockerfile, run.py, or requirements.txt
- **Environment**: Ubuntu with Python 3.10
- **Steps**:
  - Code checkout and Python setup
  - Install linting tools (flake8, bandit)
  - Run Flake8 for code style checking
  - Run Bandit for Python security scanning
  - Run Trivy filesystem vulnerability scan

### Job 2: build-and-scan
- **Dependency**: Requires build-and-test to pass
- **Steps**:
  - Setup Docker Buildx and AWS credentials
  - Login to Amazon ECR
  - Build Docker image with caching (tagged with commit SHA)
  - Scan Docker image with Trivy for vulnerabilities
  - Push to ECR if scans pass

### Job 3: update-helm-values
- **Purpose**: GitOps deployment automation
- **Steps**:
  - Checkout separate Helm repository
  - Update values.yaml with new image tag
  - Commit and push changes to trigger deployment

**Required Secrets**: AWS credentials, ECR registry details, GitHub PAT for Helm repo access

## Security

- Security scanning with Bandit for Python code
- Container vulnerability scanning with Trivy
- Multi-stage Docker build for minimal attack surface

