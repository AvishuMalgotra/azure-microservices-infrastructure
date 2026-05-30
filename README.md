# Azure Microservices Infrastructure (AKS & ACR)

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

A production-grade, modular Terraform repository for deploying a robust Azure environment optimized for microservices. This project implements advanced HCL features like nested maps, dynamic blocks, and environment-based separation.

## 🏗 Architecture Overview

The repository follows a **Module -> Environment** pattern to ensure scalability and DRY (Don't Repeat Yourself) code:

- **Modules**: Reusable building blocks (ACR, AKS, Resource Group) with dynamic configuration.
- **Envs**: Environment-specific entry points (Dev, Prod) that utilize the shared modules.
- **CI/CD**: Automated deployment via GitHub Actions with Service Principal authentication.

## 📁 Repository Structure

```text
.
├── .github/workflows/   # CI/CD Pipeline (Dev -> Prod)
├── envs/
│   ├── dev/            # Development Environment (Small SKU, Cost Optimized)
│   └── prod/           # Production Environment (High Availability, Premium SKU)
├── modules/
│   ├── acr/            # Azure Container Registry with Georeplication
│   ├── aks/            # Azure Kubernetes Service with Multi-Node Pools
│   └── resource_group/ # Standardized Resource Group Module
└── README.md           # You are here!
```

## 🚀 Getting Started

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) (>= 1.3.0)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure Subscription

### Authentication
This project uses an **Azure App Registration (Service Principal)** for both local development and CI/CD.

1. **Create the Service Principal**:
   ```bash
   az ad sp create-for-rbac --name "github-actions-infra" --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID>
   ```

2. **Configure GitHub Secrets**:
   Add the following secrets to your repository:
   - `AZURE_CLIENT_ID`
   - `AZURE_CLIENT_SECRET`
   - `AZURE_TENANT_ID`
   - `AZURE_SUBSCRIPTION_ID`

### Local Deployment
To deploy the development environment locally:

```bash
cd envs/dev
terraform init
terraform plan
terraform apply
```

## 🛠 Advanced Features Implemented

- **Dynamic Node Pools**: AKS module supports `for_each` based additional node pools for diverse workloads.
- **Nested Infrastructure Maps**: Orchestrate entire environments from a single `infrastructure_map` in `.tfvars`.
- **Conditional Creation**: Logic-based resource provisioning (e.g., only create ACR if config is provided).
- **Environment Isolation**: Separate state files and configurations for Dev and Prod.

## 🤖 CI/CD Workflow

The GitHub Actions pipeline (`.github/workflows/terraform-deploy.yml`) includes:
1. **Validation**: Auto-runs on every PR.
2. **Dev Deploy**: Applies changes to the Dev environment on merge to `main`.
3. **Prod Deploy**: Applies changes to Prod after Dev succeeds (supports Manual Approval via GitHub Environments).

## 📄 License
This project is licensed under the MIT License.
