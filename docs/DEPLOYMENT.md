# 🚀 Deployment Guide

## Prerequisites

### Hardware
- Raspberry Pi 4/5 (4GB+ RAM recommended)
- 64GB+ microSD card (Class 10)
- Network storage (optional but recommended)

### Software
- Debian/Ubuntu ARM64
- Docker + Docker Compose
- Kubernetes (K3s)
- Git

## Quick Start Deployment

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/homelab.git
cd homelab
```

### 2. Install Dependencies
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Install Ansible
sudo apt install ansible -y
```

### 3. Configure System
```bash
# Enable cgroup (required for K3s)
sudo nano /boot/firmware/cmdline.txt
# Add: cgroup_memory=1 cgroup_enable=memory

# Reboot
sudo reboot
```

### 4. Deploy with Terraform
```bash
cd terraform-homelab
terraform init
terraform plan
terraform apply -auto-approve
```

### 5. Deploy Kubernetes Services
```bash
cd ../k8s-manifests/monitoring
kubectl apply -f prometheus-config.yaml
kubectl apply -f node-exporter.yaml
kubectl apply -f prometheus.yaml
kubectl apply -f grafana.yaml
```

### 6. Configure Ansible Automation
```bash
cd ../../ansible-homelab
ansible-playbook -i inventory.yml check-homelab.yml
```

## Service-Specific Deployment

### Nextcloud
```bash
cd docker-compose/nextcloud
docker-compose up -d
```

### WireGuard VPN
```bash
cd docker-compose/wireguard
docker-compose up -d

# Get client config
docker exec -it wireguard cat /config/peer_phone/peer_phone.conf
```

### Monitoring Stack
Already deployed via K8s manifests above.

Access:
- Prometheus: http://your-ip:30090
- Grafana: http://your-ip:30300 (admin/admin)

## Post-Deployment

### Verify Services
```bash
# Check Docker containers
docker ps

# Check K8s pods
kubectl get pods -A

# Check Terraform state
cd terraform-homelab
terraform show
```

### Configure Backups
```bash
# Add to crontab
crontab -e

# Add line:
0 3 * * * /home/yourusername/ansible-homelab/backup.sh
```

### Security Hardening
```bash
# Configure firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 51820/udp  # WireGuard only
sudo ufw enable
```

## Troubleshooting

### K3s Won't Start
```bash
# Check cgroup enabled
cat /proc/cgroups | grep memory

# Restart K3s
sudo systemctl restart k3s
```

### Terraform Apply Fails
```bash
# Re-initialize
terraform init -upgrade

# Check provider versions
terraform version
```

### Pods CrashLooping
```bash
# Check logs
kubectl logs -n namespace pod-name

# Check events
kubectl get events -n namespace
```
