# 🌐 Azure Terraform Labs

[![Terraform](https://img.shields.io/badge/Terraform-1.x-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft%20Azure-Cloud%20IaC-0078D4?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Status](https://img.shields.io/badge/Status-Learning%20%26%20Hands--On%20Practice-success)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A hands-on repository dedicated to learning and mastering **Infrastructure as Code (IaC)** on **Microsoft Azure** using **Terraform**. This repository documents the journey from core Terraform and Azure fundamentals to real-world cloud architectures.

---

## 📌 Repository Overview

This repository captures step-by-step configurations, architecture experiments, and practical scripts for provisioning Azure cloud infrastructure declaratively.

### 🎯 Key Focus Areas
- Understanding Terraform core workflow (`init`, `plan`, `apply`, `destroy`).
- Structuring clean HashiCorp Configuration Language (HCL) code.
- Managing dependencies using implicit references and explicit `depends_on`.
- Leveraging Terraform `locals` blocks to reduce code duplication.
- Provisioning compute, networking, security, and storage on Azure safely.

---

## 📂 Repository Structure

```plaintext
azure-terraform-labs/
├── practice/                       # Topic-by-topic code snippets and notes
│   ├── 1storageac contai blob.txt  # Storage Accounts, Containers & Blobs
│   ├── Vnet subnet .txt            # Virtual Networks & Subnet structures
│   ├── subnet as separate.txt      # Decoupled Subnet resource configurations
│   ├── subnets in local.txt        # Managing subnets dynamically using locals
│   ├── defining vnet in local...   # VNet parameterization with local blocks
│   ├── public ip.txt               # Public IP address provisioning
│   ├── nsg.txt                     # Network Security Groups (NSGs) & rules
│   ├── NIC.txt                     # Network Interface (NIC) configuration
│   └── vm.txt                      # Virtual Machine configurations
│
├── technical GG/                   # End-to-end integrated Terraform projects
│   └── main.tf                     # Full infrastructure deployment stack
│
├── .gitignore                      # Excludes .terraform, *.tfstate, and secrets
└── README.md                       # Repository documentation
```

---

## 🛠️ Modules & Topics Practiced

| Category | Azure Resources Provisioned | Terraform Concepts Used |
| :--- | :--- | :--- |
| **Foundations** | `azurerm_resource_group` | Providers, resource blocks, arguments |
| **Networking** | `azurerm_virtual_network`, `azurerm_subnet`, `azurerm_public_ip` | CIDR blocks, implicit dependencies |
| **Security** | `azurerm_network_security_group`, `azurerm_network_security_rule` | Inbound/outbound rules, port security |
| **Compute** | `azurerm_network_interface`, `azurerm_linux_virtual_machine`, `azurerm_managed_disk` | Disk attachments, explicit `depends_on`, SSH keys |
| **Storage** | `azurerm_storage_account`, `azurerm_storage_container`, `azurerm_storage_blob` | Access tiers, replication types |
| **Code Hygiene** | `locals { ... }` blocks | DRY (Don't Repeat Yourself) configurations |

---

## 🚀 Getting Started

### Prerequisites
1. **Azure CLI**: Installed and logged in (`az login`).
2. **Terraform CLI**: Installed (version 1.5+ recommended).
3. **Active Azure Subscription**.

### Quick Run Commands

```powershell
# 1. Navigate to the project directory
cd "technical GG"

# 2. Initialize working directory & download AzureRM provider
terraform init

# 3. Preview execution plan
terraform plan

# 4. Provision resources in Azure
terraform apply -auto-approve

# 5. Clean up all resources when done (avoid unnecessary cloud costs!)
terraform destroy -auto-approve
```

---

## 🔒 Security & Best Practices

- **State File Security:** Remote state and local `.tfstate` files contain sensitive attributes. State files and `.terraform` directories are strictly excluded via `.gitignore`.
- **Resource Cleanup:** Always run `terraform destroy` after practice labs to avoid incurring Azure subscription costs.

---

## 📈 Learning Roadmap

- [x] Basic Resource Provisioning & Resource Groups
- [x] Azure Virtual Network & Subnet Architectures
- [x] Public IPs, NSGs & Network Interfaces
- [x] Virtual Machines & Managed Data Disks
- [x] Azure Storage Accounts, Containers & Blobs
- [ ] Terraform Input Variables (`variables.tf`) & Outputs (`outputs.tf`)
- [ ] Remote State Storage in Azure Blob Storage Backend
- [ ] Reusable Terraform Modules
- [ ] CI/CD Pipeline deployment via GitHub Actions

---

## 👤 Author
- **GitHub:** [@vishesh-i-tech](https://github.com/vishesh-i-tech)
