# AWS EKS Application Deployment using Terraform, Kubernetes, and Ingress

## 📌 Project Overview

This project demonstrates how to deploy a containerized application on AWS using **Infrastructure as Code**, **Kubernetes**, and **Ingress-based traffic routing**.

The infrastructure is provisioned using **Terraform**, the Kubernetes cluster runs on **Amazon EKS**, and the application is deployed using Kubernetes manifests via **kubectl**. The application is exposed to the internet using **Ingress with an AWS Application Load Balancer (ALB)**.

This project simulates a real-world DevOps workflow including:

* Infrastructure provisioning
* Kubernetes cluster management
* Container deployment
* Ingress-based traffic routing
* Git-based version control

---

# 🏗 Architecture

Internet
↓
AWS Application Load Balancer (ALB)
↓
Kubernetes Ingress
↓
Kubernetes Service (ClusterIP)
↓
Pods
↓
Containerized Application (NGINX)

---

# ⚙️ Technologies Used

* Terraform (Infrastructure as Code)
* Amazon Web Services (AWS)
* Amazon EKS (Managed Kubernetes Service)
* Kubernetes
* Docker containers
* AWS Application Load Balancer
* kubectl CLI
* Git & GitHub

---

# 📂 Project Structure

```
.
├── deployment.yaml
├── service.yaml
├── ingress.yaml
├── main.tf
├── provider.tf
├── variables.tf
├── output.tf
├── terraform.tfvars
├── module/
└── README.md
```

### Explanation

deployment.yaml
Defines the Kubernetes Deployment that runs the application containers.

service.yaml
Creates a Kubernetes Service to expose the pods internally inside the cluster.

ingress.yaml
Defines the Ingress resource that routes external traffic to the service using AWS ALB.

Terraform files
Used to provision AWS infrastructure including VPC, subnets, and the EKS cluster.

---

# 🚀 Step 1 — Provision Infrastructure using Terraform

Initialize Terraform

```
terraform init
```

Preview infrastructure changes

```
terraform plan
```

Create infrastructure

```
terraform apply
```

Terraform will provision the following AWS resources:

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* Route Tables
* Security Groups
* Amazon EKS Cluster
* Worker Node Group

Once the cluster is created, configure kubectl to communicate with the cluster.

```
aws eks update-kubeconfig --region ap-south-1 --name my-cluster
```

Verify cluster connection:

```
kubectl get nodes
```

You should see worker nodes in **Ready** state.

---

# 📦 Step 2 — Deploy Application using Kubernetes

Applications in Kubernetes run inside **Pods**. Pods are managed by **Deployments**.

## Create Deployment

```
kubectl apply -f deployment.yaml
```

Verify deployment:

```
kubectl get deployments
```

Check pods:

```
kubectl get pods
```

You should see pods running.

Example:

```
hello-world-app   Running
```

Check logs if needed:

```
kubectl logs hello-world-app
```

---

# 🌐 Step 3 — Create Kubernetes Service

Pods have dynamic IP addresses, so we expose them using a **Service**.

Apply the service manifest:

```
kubectl apply -f service.yaml
```

Check service:

```
kubectl get svc
```

Typical output:

```
NAME                 TYPE        CLUSTER-IP
hello-world-service  ClusterIP   172.20.0.8
```

This service exposes the pods internally within the Kubernetes cluster.

---

# 🌍 Step 4 — Install AWS Load Balancer Controller

Ingress requires the AWS Load Balancer Controller to create ALB resources automatically.

Steps include:

1. Create IAM policy
2. Create IAM role for service account
3. Install controller using Helm
4. Verify controller pods

Verify controller:

```
kubectl get pods -n kube-system
```

You should see:

```
aws-load-balancer-controller
```

---

# 🌍 Step 5 — Create Ingress Resource

Ingress allows routing HTTP/HTTPS traffic from outside the cluster to internal services.

Apply ingress configuration:

```
kubectl apply -f ingress.yaml
```

Check ingress resource:

```
kubectl get ingress
```

Example output:

```
NAME            HOSTS    ADDRESS
hello-ingress   *        k8s-default-hellowor-6f19c804e6-799072878.ap-south-1.elb.amazonaws.com/
```

The **ADDRESS** field is the DNS name of the AWS Application Load Balancer.

---

# 🌍 Step 6 — Access the Application

Open the ALB DNS in your browser:

```
http://k8s-default-hellowor-6f19c804e6-799072878.ap-south-1.elb.amazonaws.com/
```

The request flow:

User Request
↓
AWS Application Load Balancer
↓
Ingress Controller
↓
Kubernetes Service
↓
Pods
↓
Application Response

---

# 🔎 Useful kubectl Commands

Check cluster nodes

```
kubectl get nodes
```

Check running pods

```
kubectl get pods
```

Check services

```
kubectl get svc
```

Check ingress

```
kubectl get ingress
```

Describe resources

```
kubectl describe pod POD_NAME
kubectl describe svc SERVICE_NAME
kubectl describe ingress INGRESS_NAME
```

View logs

```
kubectl logs POD_NAME
```

---

# 🔄 Deployment Flow

Developer pushes code to GitHub
↓
Infrastructure created using Terraform
↓
EKS cluster runs Kubernetes
↓
Application deployed using kubectl
↓
Ingress exposes service using ALB
↓
Users access application through the internet

---

# 📈 Possible Improvements

Implement CI/CD pipeline using GitHub Actions
Add monitoring with Prometheus and Grafana
Use Helm charts for application packaging
Enable autoscaling with Kubernetes HPA
Add HTTPS using AWS Certificate Manager

---

# 👨‍💻 Author

Rudraksha Asati
DevOps & Cloud Enthusiast
