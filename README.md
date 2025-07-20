
# DevSecOps Pipeline with Terraform, GitHub Actions, tfsec, Trivy & Sealed Secrets

This project demonstrates a complete DevSecOps CI/CD pipeline that includes infrastructure security scanning, container vulnerability scanning, secret management with Sealed Secrets, and Kubernetes deployment.

## 🔧 Tools Used

- **Terraform**: Infrastructure as Code (IaC) to provision AWS resources
- **tfsec**: Static analysis for Terraform security issues
- **Trivy**: Container vulnerability scanner
- **GitHub Actions**: CI/CD automation
- **Sealed Secrets**: Secure secret management for Kubernetes
- **Minikube**: Local Kubernetes cluster for testing
- **Docker**: For containerizing and pushing application images

## 🗂 Project Structure

```
Devops-Master-Project/
│
├── .github/workflows/
│   └── ci-cd.yml               # GitHub Actions pipeline
│
├── terraform/
│   ├── main.tf                 # Terraform AWS infra
│   └── variables.tf            # Input variables
│
├── sealed-secrets/
│   ├── secret.yml              # Plaintext Docker credentials (not committed)
│   └── sealedsecret.yml        # Encrypted version of the secret
│
├── k8s/
│   └── deployment.yml          # Deployment spec for Kubernetes
│
├── Dockerfile                  # Builds the Node.js app image
├── app/                        # Your Node.js app
│
└── README.md                   # You're here
```

## ⚙️ CI/CD Workflow

The pipeline runs on every push to the main branch and includes the following stages:

1. **Terraform Security Scan (tfsec)**  
   - Scans the Terraform code for security issues.
2. **Terraform Apply**  
   - Applies infrastructure changes to AWS.
3. **Docker Build & Trivy Scan**  
   - Builds the Docker image.
   - Scans the image for known vulnerabilities.
4. **Docker Push**  
   - Pushes the image to Docker Hub.
5. **Kubernetes Deploy**  
   - Applies `deployment.yml` using `kubectl`.
   - Pulls Docker credentials from `SealedSecret`.

## 🔐 Secret Management

Secrets (e.g., DockerHub credentials) are sealed using Bitnami's Sealed Secrets and safely stored in Git:

```bash
kubeseal --cert pub-cert.pem \
  --controller-name sealed-secrets \
  --controller-namespace kube-system \
  --format yaml < sealed-secrets/secret.yml > sealed-secrets/sealedsecret.yml
```

> Use the `kubeseal` binary with the public cert extracted from your Sealed Secrets controller on Minikube.

## 🚀 Deploy to Minikube

1. **Start Minikube**
   ```bash
   minikube start
   ```

2. **Install Sealed Secrets controller**
   ```bash
   helm install sealed-secrets bitnami/sealed-secrets --namespace kube-system
   ```

3. **Apply Deployment**
   ```bash
   kubectl apply -f sealed-secrets/sealedsecret.yml
   kubectl apply -f k8s/deployment.yml
   ```

## ✅ Verification

- Check if the pod is running:
  ```bash
  kubectl get pods
  ```

- Port-forward to access the app:
  ```bash
  kubectl port-forward pod/<your-node-app-pod> 3000:3000
  ```

- Access your app at [http://localhost:3000](http://localhost:3000)

## 🛡 Security Features Summary

| Feature              | Tool         |
|----------------------|--------------|
| Terraform Scan       | tfsec        |
| Docker Image Scan    | Trivy        |
| Secret Encryption    | SealedSecrets|
| Infra Provisioning   | Terraform    |
| CI/CD                | GitHub Actions|

## 📦 Docker Image

Make sure your image is available on Docker Hub:

```
docker build -t your-username/your-app-name:latest .
docker push your-username/your-app-name:latest
```
