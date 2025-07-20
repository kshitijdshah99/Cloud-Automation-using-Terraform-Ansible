# Cloud Automation: Terraform & Ansible

Automated provisioning and configuration of Azure infrastructure using **Terraform** and **Ansible**.

---

## 📂 Repository Overview

Each folder targets a specific Azure service or infrastructure pattern:

* `Terraform AKS/` – Azure Kubernetes Service deployment
* `Terraform Application Gateway/` – Perimeter gateway setup
* `Terraform CosmosDB/` – Cosmos DB provisioning
* `Terraform Load Balancer/` – Standard LB configuration
* `Terraform MySQL and Private end-point/` – MySQL with private endpoint
* `Terraform Postgre DB and Private end-point/` – PostgreSQL with private endpoint
* `Terraform Storage Account Scripts/` – Storage account deployments
* `Terraform VM Scripts/` – Virtual machine creation + Ansible bootstrap
* `Terraform Vnet Scripts/` – Virtual network and subnets setup

Each directory contains `.tf` files (Terraform configurations), `.tfvars` (variables), and `providers.tf`.

---

## 🚀 Getting Started

### Prerequisites

* Terraform v1.x installed
* Ansible v2.15+ installed
* Azure CLI logged into subscription
* SSH key for VM access (for Ansible)

### Setup Terraform

```bash
cd "<module-folder>"
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### Bootstrap VMs with Ansible

After provisioning VMs:

```bash
cd "Terraform VM Scripts"
ansible-playbook -i hosts.ini install_chrome.yml --private-key /path/to/key
```

Adjust paths and playbooks according to your needs.

---

## 🧩 How It Works Together

1. **Terraform** creates infrastructure (networks, DBs, VMs, etc.).
2. **Ansible** connects to provisioned VMs over SSH and configures them.
3. VM setup includes installing dependencies, configuring services, or deploying applications.

---

## 🎯 Folder Breakdown

| Folder                              | Description                          |
| ----------------------------------- | ------------------------------------ |
| `Terraform AKS`                     | AKS + managed resources              |
| `Terraform Application Gateway`     | WAF-enabled gateway deployment       |
| `Terraform CosmosDB`                | Provisioning globally distributed DB |
| `Terraform Load Balancer`           | Internal/external LB with rules      |
| `Terraform MySQL ...`               | Private endpoint MySQL DB            |
| `Terraform Postgre DB ...`          | Private endpoint PostgreSQL DB       |
| `Terraform Storage Account Scripts` | Storage accounts for data/archive    |
| `Terraform VM Scripts`              | Generates VMs and invokes Ansible    |
| `Terraform Vnet Scripts`            | VNet/subnet/SPG/NSG configurations   |

---

## 🛠️ Usage Workflow

1. **Deploy infrastructure**
   Navigate into the folder of choice and run Terraform.

2. **Run Ansible (if required)**
   In `Terraform VM Scripts/` follow playbook instructions to configure VMs.

3. **Scale or update**
   Re-run Terraform & Ansible; changes are idempotent.

---

## ✅ Best Practices

* Use `terraform fmt` and `terraform validate` before apply
* Commit and review code using Git branches & PRs
* Consider remote states (e.g., Azure Storage backend) for team collaboration
* Add a `.gitignore` to prevent committing sensitive files (keys, `.tfvars` with secrets)

---

## 📘 Further Steps

* Add modular Terraform code with `modules/`
* Integrate Azure Key Vault for secret storage
* Add CI pipelines (GitHub Actions, Azure DevOps)
* Document outputs and input defaults in `README.md` of each folder

---

## 📝 License

Specify your intended license (e.g., MIT, Apache 2.0) here.

---

### Usage Examples

```bash
# AKS Example
cd "Terraform AKS"
terraform init && terraform apply -auto-approve

# VM + Ansible example
cd "Terraform VM Scripts"
terraform init && terraform apply -auto-approve
ansible-playbook -i hosts.ini install_chrome.yml
```

---

## 🛍️ Support

For questions or issues:

* Open a GitHub Issue
* Include logs, error messages, and context

---

### 👍 Contributions

PRs are welcome! To contribute:

1. Fork the repo
2. Create a new branch
3. Make changes
4. Submit a PR for review

---

*Happy automating!* 🚀
