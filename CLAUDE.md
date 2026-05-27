# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a local lab for practicing DevOps and microservices architecture. Work is organized into **git branches per lab topic** — each branch is a self-contained lab, not a feature branch to be merged into main.

| Branch | Purpose |
|--------|---------|
| `01.GenericVM` | Infrastructure scripts: Multipass VMs, Terraform, K3D, Helm, CoreDNS, nginx |
| `02.DigitalBank` | Digital Bank microservices app (Java Spring Boot, RabbitMQ, Redis, PostgreSQL) |

## Infrastructure Setup (Branch: 01.GenericVM)

Scripts must be run in order within each numbered directory:

### VM Provisioning (`01.VM/`)
```bash
# 1. Provision Ubuntu 24.04 VM via Multipass + Terraform
bash 01.VM/00.provision-vm.sh        # Creates VM, outputs IP to result.yaml

# 2. Install packages inside the VM (Docker, Java 21, Maven, Gradle, Git)
bash 01.VM/01.install-packages.sh    # Transfers and runs zz.01.install-packages.sh on VM
```

Terraform state lives in `01.VM/terraform/`. The SSH public key is injected into `cloud-init.yaml` at provision time (`sed` replaces `__SSH_KEY__`). VM defaults: 4 CPUs, 6 GB RAM, 40 GB disk, image `24.04`.

### K3D + Helm + kubectl (`02.K3D+Helm+Kubectl/`)
```bash
bash 02.K3D+Helm+Kubectl/01.k3d.sh   # Install k3d, kubectl; create cluster tdc-cluster (port 8080→80)
bash 02.K3D+Helm+Kubectl/02.Helm.sh  # Install Helm 3
bash 02.K3D+Helm+Kubectl/03.CoreDNS-Mapping.sh  # Point CoreDNS forwarder at local DNS server
```

K3D cluster name: `tdc-cluster`, 3 agents, LoadBalancer on `8080:80`.

### nginx + Docker + CoreDNS (`03.nginx+Docker+CoreDNS/`)
```bash
bash 03.nginx+Docker+CoreDNS/01.Link-Docker-CoreDNS.sh  # Set Docker DNS → CoreDNS IP; restart Docker
bash 03.nginx+Docker+CoreDNS/02.CreateDBs.sh
bash 03.nginx+Docker+CoreDNS/02.nginx+Gateway.sh
bash 03.nginx+Docker+CoreDNS/03.CoreDNS-Mapping.sh
```

Docker DNS config goes in `/etc/docker/daemon.json`; replace `DNS_IP_Address` with the CoreDNS container IP.

## Digital Bank Architecture (Branch: 02.DigitalBank)

Planned directory layout (not yet created):
```
/infra      — Terraform + Ansible provisioning scripts
/backend    — Java Spring Boot microservices
/react      — ReactJS frontend  →  https://digital.bank.labs
/angular    — Angular frontend  →  https://angular.digital.bank.labs
/api/dbs/   — Flyway SQL migration scripts (*.sql)
```

Backend API base URL: `http://api.digital.bank.labs`

**Key stack:** Java Spring Boot · RabbitMQ (broker) · Redis (cache) · PostgreSQL (primary DB) · Flyway (DB migrations, run manually via Docker — not embedded in the application).

## VM Topology

| VM | Services |
|----|---------|
| `vm-dbs` | PostgreSQL (5432), MySQL (3306), MongoDB |
| `vm-services` | Redis, RabbitMQ, Keycloak (AuthServer) |
| `vm-logs` | Grafana, Loki |
| `vm-dev` / `vm-qa` / `vm-stg` | Environment VMs |

## Versioning

All deployments use **`x.y.z` semver**. Minor versions (`x.y.*`) maintain API backward compatibility. Major bumps (`x.0.0`) may break APIs.

## DB Migrations

Flyway migrations are run **manually via Docker**, not auto-applied by the application on startup. SQL scripts live in `/api/dbs/`. Always run migrations before deploying a new backend version.