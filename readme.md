# 🏠 Homelab Infrastructure - Self-Hosted Cloud & DevOps Platform

> Enterprise-grade homelab running on Raspberry Pi 5, showcasing modern DevOps practices, container orchestration, and infrastructure automation.

[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?logo=kubernetes)](https://k3s.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible)](https://www.ansible.com/)
[![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)](https://prometheus.io/)
[![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker)](https://www.docker.com/)

---

## 🎯 Project Overview

Self-hosted infrastructure featuring:
- **Container Orchestration** with Kubernetes (K3s)
- **Infrastructure as Code** using Terraform
- **Configuration Management** via Ansible
- **Monitoring & Observability** with Prometheus + Grafana
- **Secure Remote Access** through WireGuard VPN
- **Private Cloud Storage** with Nextcloud
- **Self-Hosted Password Manager** (Vaultwarden)
- **Home Automation** platform (Home Assistant)

**Uptime:** 99.9% | **Services:** 9+ | **Cost:** €0/month

---

## 🏗️ Architecture
```
┌─────────────────────────────────────────────┐
│         Internet (via WireGuard VPN)        │
│              Port 51820/UDP                  │
└──────────────────┬──────────────────────────┘
                   │
         ┌─────────▼─────────┐
         │   Raspberry Pi 5  │
         │   Debian/K3s      │
         └─────────┬─────────┘
                   │
    ┌──────────────┼──────────────┐
    │              │              │
┌───▼───┐    ┌────▼────┐    ┌───▼───┐
│Docker │    │Kubernetes│    │ NAS   │
│Stack  │    │  Pods    │    │Storage│
└───────┘    └─────────┘    └───────┘
```

---

## 🛠️ Technology Stack

### Container Orchestration
- **Kubernetes (K3s)**: Lightweight K8s for ARM64
- **Docker Compose**: Legacy service management
- **Traefik**: Ingress controller

### Infrastructure as Code
- **Terraform**: Multi-provider infrastructure provisioning
- **Ansible**: Configuration management & automation

### Monitoring & Observability
- **Prometheus**: Metrics collection
- **Grafana**: Visualization dashboards
- **Node Exporter**: System metrics
- **Uptime Kuma**: Service monitoring

### Security
- **WireGuard VPN**: Secure remote access
- **UFW Firewall**: Network security
- **Vaultwarden**: Password management
- **SSL/TLS**: Encrypted communications

### Services
- **Nextcloud**: Private cloud (100GB+ on NAS)
- **Pi-hole**: Network-wide ad blocking
- **Home Assistant**: Home automation
- **Portainer**: Container management UI
- **Nginx Proxy Manager**: Reverse proxy

---

## 📊 Infrastructure Metrics

| Metric | Value |
|--------|-------|
| **Uptime** | 99.9% (30 days) |
| **Containers** | 9+ active |
| **Storage** | 1.8TB (NAS) |
| **CPU Usage** | ~15% avg |
| **Memory** | 2.5GB / 16GB |
| **Network** | VPN-only access |
| **Backup** | Daily automated |

---

## 🚀 Quick Start

### Prerequisites
- Raspberry Pi 4/5 (4GB+ RAM)
- Ubuntu/Debian ARM64
- Network storage (optional)

### 1. Clone Repository
```bash
git clone https://github.com/tuousername/homelab.git
cd homelab
```

### 2. Deploy with Terraform
```bash
cd terraform-homelab
terraform init
terraform plan
terraform apply
```

### 3. Configure with Ansible
```bash
cd ansible-homelab
ansible-playbook -i inventory.yml deploy-homelab.yml
```

### 4. Verify Deployment
```bash
kubectl get pods -A
docker ps
```

---

## 📁 Repository Structure
```
homelab/
├── terraform-homelab/       # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── modules/
│   │   ├── docker/
│   │   ├── kubernetes/
│   │   └── monitoring/
│   └── README.md
│
├── ansible-homelab/         # Configuration Management
│   ├── inventory.yml
│   ├── playbooks/
│   │   ├── deploy-homelab.yml
│   │   ├── backup.yml
│   │   └── update.yml
│   └── README.md
│
├── k8s-manifests/           # Kubernetes Deployments
│   ├── nextcloud/
│   ├── monitoring/
│   │   ├── prometheus/
│   │   └── grafana/
│   └── README.md
│
├── docker-compose/          # Docker Compose Stacks
│   ├── nextcloud/
│   ├── wireguard/
│   └── vaultwarden/
│
├── scripts/                 # Utility Scripts
│   ├── backup.sh
│   ├── monitoring.sh
│   └── duckdns-update.sh
│
└── docs/                    # Documentation
    ├── ARCHITECTURE.md
    ├── DEPLOYMENT.md
    └── TROUBLESHOOTING.md
```

---

## 🔒 Security Features

- ✅ **Zero Trust**: No public HTTP/HTTPS ports
- ✅ **VPN-Only Access**: WireGuard tunnel required
- ✅ **Firewall**: UFW with strict rules
- ✅ **SSL/TLS**: All services encrypted
- ✅ **Automated Backups**: Daily to NAS
- ✅ **Secret Management**: Vaultwarden self-hosted

---

## 📈 Monitoring Dashboards

**Grafana Dashboards:**
- Kubernetes Cluster Overview (ID: 15759)
- Node Exporter Full (ID: 1860)
- Custom Homelab Dashboard

**Prometheus Metrics:**
- CPU, Memory, Disk, Network
- Container statistics
- Service health checks
- Custom alerting rules

**Access:** `http://192.168.1.12:30300` (via VPN)

---

## 🔄 Automation

### Ansible Playbooks
- `deploy-homelab.yml`: Full infrastructure deployment
- `backup.yml`: Automated backup routine
- `update.yml`: System & container updates
- `monitoring.yml`: Health checks

### Cron Jobs
```bash
# Daily backup at 3:00 AM
0 3 * * * /home/bilalis/ansible-homelab/backup.sh

# Hourly monitoring
0 * * * * /home/bilalis/ansible-homelab/check-homelab.yml
```

---

## 💡 Lessons Learned

### Technical Challenges
- **Storage**: SQLite incompatible with NAS/SMB → Used emptyDir
- **Permissions**: K8s pod security contexts required careful tuning
- **Networking**: NodePort for external access, ClusterIP for internal

### Best Practices Implemented
- Infrastructure as Code for reproducibility
- GitOps workflow for version control
- Automated testing before production deploy
- Comprehensive monitoring and alerting
- Regular automated backups with retention policy

---

## 🎓 Skills Demonstrated

**DevOps & Cloud:**
- Container orchestration (Kubernetes)
- Infrastructure automation (Terraform, Ansible)
- CI/CD concepts and implementation
- Monitoring & observability (Prometheus, Grafana)

**System Administration:**
- Linux server management (Debian/Ubuntu)
- Networking (VPN, DNS, firewalls)
- Storage management (NAS, volumes)
- Security hardening

**Automation & Scripting:**
- Bash scripting
- YAML configuration
- HCL (Terraform)
- Python (for custom tools)

---

## 📚 Documentation

- [Architecture Overview](docs/ARCHITECTURE.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Backup & Recovery](docs/BACKUP.md)

---

## 🤝 Contributing

This is a personal learning project, but suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## 📜 License

MIT License - feel free to use this as inspiration for your own homelab!

---

## 📧 Contact

**Bilal** - Almost a DevOps Engineer  
📧 Email: bilalis@hotmail.it  
💼 LinkedIn: (https://linkedin.com/in/bilal-ismail-b1161758)  


---

## 🌟 Acknowledgments

- Kubernetes community for K3s
- HashiCorp for Terraform
- Prometheus/Grafana teams
- Homelab community on Reddit

---

<p align="center">Made with ❤️ and lots of ☕</p>
<p align="center">⭐ Star this repo if you find it helpful!</p>
