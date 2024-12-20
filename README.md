<div align="center">

# 🛠️ DevOps Toolkit Installer

![DevOps Toolkit](https://img.shields.io/badge/DevOps-Toolkit-blue?style=for-the-badge&logo=docker)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Made with Make](https://img.shields.io/badge/Made%20with-Make-1f425f.svg)](https://www.gnu.org/software/make/)

*A comprehensive toolkit for DevOps engineers to set up their development environment*

</div>

---

## 🎯 Overview
This toolkit provides a simple way to install and manage common DevOps tools using Makefiles. It supports automatic installation of various cloud, containerization, and development tools on Ubuntu-based systems.

## 🚀 Quick Start

1. **Clone this repository:**   ```
   git clone https://github.com/bhomesh/useful_makefile.git   ```
2. **Navigate to the project directory:**   ```
   cd useful_makefile   ```
3. **Install all tools:**   ```
   make install_all   ```
   Or install specific tools:   ```
   make docker
   make kubectl   ```

## 🧰 Available Tools

| Category | Tools |
|----------|-------|
| 🐳 Containerization | Docker |
| 🐚 Shell | Zsh + Oh My Zsh |
| 🐍 Python | Python3, Pip |
| ☕ Java | JDK, JVM |
| 📦 Node.js | Node.js, NPM, NVM |
| 🌐 Networking | Curl |
| ✏️ Text Editor | Vim |
| 📦 Compression | Unzip |
| 🔄 Version Management | NVM |
| ☁️ Cloud & Orchestration | eksctl, AWS CLI, kubectl, Google Cloud SDK, Azure CLI |
| 🚢 Kubernetes Development | Minikube, Kind, Kubeadm, Helm |
| 🏗️ Infrastructure as Code | Terraform, Ansible, Chef, Puppet |
| 📊 Monitoring & Observability | Prometheus, Grafana, Glasscube, Thanos |
| 🔍 Code Quality & CI/CD | SonarQube, Jenkins, CodeClimate |
| 💾 Databases | MySQL, MariaDB, PostgreSQL, Redis, MongoDB, MongoDB Compass |
| 🔧 Programming Languages | Go, Terragrunt, TFSec, TFLint, TFEnv |
| 🌐 Web Servers | Nginx, Apache |
| 📸 Screenshot Tools | Flameshot |
| 💽 System Tools | GParted |

## 📋 Usage Guide

| Command | Description |
|---------|-------------|
| `make help` | Display available commands |
| `make install_all` | Install all tools |
| `make <tool_name>` | Install a specific tool (e.g., `make docker`, `make helm`) |
| `make <TOOL_NAME>` | Check if a tool is installed (e.g., `make DOCKER`, `make HELM`) |

## 🌐 Access URLs & Tools

After installation, you can access:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (default credentials: admin/admin)
- Jenkins: http://localhost:8080 (initial password will be displayed during installation)
- SonarQube: http://localhost:9000 (default credentials: admin/admin)
- MySQL/MariaDB: localhost:3306
- PostgreSQL: localhost:5432
- MongoDB: localhost:27017
- Redis: localhost:6379
- Nginx/Apache: http://localhost:80
- MongoDB Compass: Launch from applications menu (GUI MongoDB client)

## ⚠️ Prerequisites

- Ubuntu-based system
- Sudo privileges

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. 🍴 Fork the repository
2. 🌿 Create a new branch (`git checkout -b feature/AmazingFeature`)
3. 🔧 Make your changes
4. 📊 Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. 📤 Push to the branch (`git push origin feature/AmazingFeature`)
6. 🔁 Open a Pull Request

Don't forget to give the project a star! ⭐ Thanks for your support!

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ❤️ by [Bhomesh](https://github.com/bhomesh)

</div>

## 💡 Tool Tips

### Flameshot (Screenshot Tool)
- Launch with: `flameshot gui`
- Configure keyboard shortcut (recommended: `PrtSc` key):
  1. Go to System Settings > Keyboard > Shortcuts
  2. Add custom shortcut
  3. Command: `flameshot gui`
  4. Set your preferred key combination

Features:
- Annotation tools
- Quick upload
- Area selection
- Multiple monitor support

### GParted (Partition Editor)
- Launch with: `sudo gparted` or from applications menu
- Features:
  - Create, delete, resize, move, check, and copy partitions
  - Format partitions to various file systems
  - Set partition flags
  - Align partitions for optimal performance
  - Supports many file systems (ext2/3/4, fat16/32, ntfs, etc.)

⚠️ **Warning**: Be careful when using GParted as incorrect partition operations can lead to data loss.
