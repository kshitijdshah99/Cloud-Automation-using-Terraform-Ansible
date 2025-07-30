
# ☁️ Cloud Automation using Terraform & Ansible

Infrastructure-as-Code (IaC) for provisioning and configuring Azure resources using **Terraform** and **Ansible** — including automation scripts for **Splunk**, **Crowdstrike**, and **Sapphire**.

---

## 📁 Repository Structure

This repository is modularized by Azure resource types and includes both Terraform infrastructure provisioning and Ansible-based VM configuration.

### 🔧 Infrastructure Modules

| Folder                                 | Description                                 |
| -------------------------------------- | ------------------------------------------- |
| `Terraform AKS/`                       | Deploys Azure Kubernetes Service            |
| `Terraform Application Gateway/`       | Creates a WAF-enabled Application Gateway   |
| `Terraform CosmosDB/`                  | Globally distributed Cosmos DB setup        |
| `Terraform Load Balancer/`             | Deploys internal/external load balancers    |
| `Terraform MySQL and Private end-point/` | Provisions MySQL DB with private access   |
| `Terraform Postgre DB and Private end-point/` | PostgreSQL DB with secure private endpoint |
| `Terraform Storage Account Scripts/`   | Storage account provisioning scripts        |
| `Terraform VM Scripts/`                | VM provisioning and Ansible bootstrap       |
| `Terraform Vnet Scripts/`              | Virtual Network, subnets, NSGs configuration|

### 📦 Automation Add-ons

| Folder / File                    | Description                                           |
| ------------------------------- | ----------------------------------------------------- |
| `automation_scripts.zip`        | Contains Ansible automation playbooks for:<br>• Splunk<br>• Crowdstrike<br>• Sapphire |

---

## 🚀 Getting Started

### ✅ Prerequisites

- Terraform v1.x
- Ansible v2.15+
- Azure CLI authenticated to your subscription
- SSH key pair for VM access (required by Ansible)

### ⚙️ Terraform Workflow

```bash
cd "<Terraform module>"
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### 🛠️ Run Ansible Playbooks

Once the VMs are provisioned:

```bash
cd "Terraform VM Scripts"
ansible-playbook -i hosts.ini install_chrome.yml --private-key /path/to/private_key.pem
```

> 🔄 Customize your playbooks as per application setup (e.g., Splunk, Crowdstrike, Sapphire).

---

## 🧩 How Terraform and Ansible Work Together

1. **Terraform** provisions infrastructure — networks, databases, VMs, etc.
2. **Ansible** configures the VMs by connecting over SSH.
3. Scripts can install software (e.g., Splunk, Crowdstrike agents) and configure services.

---

## 🔍 Example Usage

```bash
# Deploy AKS Cluster
cd "Terraform AKS"
terraform init && terraform apply -auto-approve

# Provision VMs and configure with Ansible
cd "Terraform VM Scripts"
terraform init && terraform apply -auto-approve
ansible-playbook -i hosts.ini install_splunk.yml
```

---

## 💡 Best Practices

- Format code: `terraform fmt`
- Validate configurations: `terraform validate`
- Use `.gitignore` to exclude sensitive files (e.g., `*.tfvars`, private keys)
- Implement remote state backend for team environments (e.g., Azure Storage)
- Follow modular code structure via `modules/` directory (recommended)

---

## 🔐 Secrets & Security

- Store sensitive credentials in **Azure Key Vault**
- Avoid hardcoding secrets in `.tfvars` or Ansible playbooks
- Use Ansible Vault for encrypting sensitive config files

---

## 🧪 Future Enhancements

- Modularize Terraform scripts under a `modules/` folder
- Add CI/CD integration (GitHub Actions or Azure DevOps)
- Auto-document input/output variables per module
- Expand Ansible roles and reusable templates

---

## 📘 Documentation for Scripts

If you're using the automation playbooks in the `.zip` file:

- Extract the archive.
- Navigate to each script (e.g., `install_splunk.yml`, `install_crowdstrike.yml`)
- Review variables and inventory in `hosts.ini`
- Ensure proper permissions on SSH keys

---

## 📝 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — you are free to use, modify, and distribute this software with proper attribution.

---

## 🙋‍♂️ Support

For bugs or feature requests:

- Open a GitHub Issue with logs and context
- Mention the module or script being used

---

## 🤝 Contributions

Pull Requests are welcome!

1. Fork this repository
2. Create a feature branch
3. Commit and push your changes
4. Open a pull request for review

---

**Happy Automating!** 🚀
