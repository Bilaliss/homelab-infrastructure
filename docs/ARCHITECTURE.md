# 🏗️ Architecture Overview

## System Diagram
```
                    INTERNET
                       │
                   [DuckDNS]
                       │
                  [Router NAT]
                       │
              ┌────────┴────────┐
              │  Raspberry Pi 5  │
              │  192.168.1.12    │
              └────────┬─────────┘
                       │
         ┌─────────────┼─────────────┐
         │             │             │
    ┌────▼────┐   ┌───▼───┐   ┌────▼────┐
    │ Docker  │   │  K3s  │   │  NAS    │
    │ Engine  │   │ K8s   │   │ Storage │
    └─────────┘   └───────┘   └─────────┘
```

## Network Architecture

**External Access:**
- WireGuard VPN: Port 51820/UDP
- Zero public HTTP/HTTPS ports

**Internal Network:**
- Subnet: 192.168.1.0/24
- Raspberry Pi: 192.168.1.12 (static)
- NAS: 192.168.1.130
- Router: 192.168.1.1

## Services Map

| Service | Type | Port | Access |
|---------|------|------|--------|
| Nextcloud | Docker | 8080 | Internal |
| Nextcloud K8s | K8s Pod | 30080 | NodePort |
| Vaultwarden | Docker | 8090 | Internal |
| WireGuard | Docker | 51820 | Public |
| Prometheus | K8s Pod | 30090 | NodePort |
| Grafana | K8s Pod | 30300 | NodePort |
| Home Assistant | Docker | 8123 | Internal |
| Pi-hole | Docker | 80/443 | Internal |
| Uptime Kuma | Docker | 3001 | Internal |

## Storage Architecture

**Local Storage (SD Card):**
- OS: 25GB / 115GB
- K8s data: /home/bilalis/k8s-data/
- Prometheus: emptyDir (ephemeral)
- Grafana: emptyDir (ephemeral)

**Network Storage (NAS):**
- Total: 1.8TB
- Nextcloud data: ~32GB
- Backups: /backups/homelab/
- Media: /media/

## Technology Stack

**Orchestration Layer:**
- Kubernetes: K3s v1.34.3
- Docker: 24.0+
- Traefik: Ingress controller

**Automation Layer:**
- Terraform: v1.x
- Ansible: v2.19

**Monitoring Layer:**
- Prometheus: metrics
- Grafana: dashboards
- Node Exporter: system metrics
- Uptime Kuma: uptime monitoring

**Security Layer:**
- WireGuard: VPN tunnel
- UFW: firewall
- SSL/TLS: encryption
