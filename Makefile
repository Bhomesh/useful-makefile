.SILENT:
# COLORS http://invisible-island.net/xterm/xterm.faq.html#other_versions
RED    := $(shell tput -Txterm setaf 1)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
MAGENTA:= $(shell tput -Txterm setaf 5)
CYAN   := $(shell tput -Txterm setaf 6)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# Check for installed tools
HAS_DOCKER 		:= $(shell command -v docker;)
HAS_ZSH 		:= $(shell command -v zsh;)
HAS_PIP 		:= $(shell command -v pip;)
HAS_CURL 		:= $(shell command -v curl;)
HAS_VIM 		:= $(shell command -v vim;)
HAS_EKSCTL 		:= $(shell command -v eksctl;)
HAS_AWSCLI 		:= $(shell command -v aws;)
HAS_KUBECTL 	:= $(shell command -v kubectl;)
HAS_GCLOUD 		:= $(shell command -v gcloud;)
HAS_AZURE 		:= $(shell command -v az;)
HAS_MINIKUBE 	:= $(shell command -v minikube;)
HAS_KIND 		:= $(shell command -v kind;)
HAS_TERRAFORM 	:= $(shell command -v terraform;)
HAS_ANSIBLE 	:= $(shell command -v ansible;)
HAS_UNZIP 		:= $(shell command -v unzip;)
HAS_PYTHON3 	:= $(shell command -v python3;)
HAS_OMZ := $(shell test -d ~/.oh-my-zsh && echo "yes" || echo "no")
HAS_NVM := $(shell command -v nvm;)
HAS_KUBEADM := $(shell command -v kubeadm;)
HAS_PROMETHEUS := $(shell command -v prometheus;)
HAS_GRAFANA := $(shell command -v grafana-server;)
HAS_SONARQUBE := $(shell command -v sonar-scanner;)
HAS_JENKINS := $(shell command -v jenkins;)
HAS_JAVA := $(shell command -v java;)
HAS_JAVAC := $(shell command -v javac;)
HAS_NODE := $(shell command -v node;)
HAS_NPM := $(shell command -v npm;)
HAS_CODECLIMATE := $(shell command -v codeclimate;)
HAS_HELM := $(shell command -v helm;)
HAS_GLASSCUBE := $(shell command -v glasscube;)
HAS_MYSQL := $(shell command -v mysql;)
HAS_MARIADB := $(shell command -v mariadb;)
HAS_POSTGRES := $(shell command -v psql;)
HAS_REDIS := $(shell command -v redis-server;)
HAS_MONGODB := $(shell command -v mongod;)
HAS_GO := $(shell command -v go;)
HAS_THANOS := $(shell command -v thanos;)
HAS_CHEF := $(shell command -v chef;)
HAS_PUPPET := $(shell command -v puppet;)
HAS_NGINX := $(shell command -v nginx;)
HAS_APACHE := $(shell command -v apache2;)
HAS_MONGODB_COMPASS := $(shell command -v mongodb-compass;)
HAS_GIT := $(shell command -v git;)
HAS_HTOP := $(shell command -v htop;)
HAS_TMUX := $(shell command -v tmux;)
HAS_TREE := $(shell command -v tree;)
HAS_NET_TOOLS := $(shell command -v netstat;)
HAS_BUILD_ESSENTIAL := $(shell command -v gcc;)
HAS_OPENSSH := $(shell command -v ssh;)
HAS_WGET := $(shell command -v wget;)
HAS_SNAP := $(shell command -v snap;)
HAS_CHROME := $(shell command -v google-chrome;)
HAS_FIREFOX := $(shell command -v firefox;)
HAS_TERRAGRUNT := $(shell command -v terragrunt;)
HAS_TFSEC := $(shell command -v tfsec;)
HAS_TFLINT := $(shell command -v tflint;)
HAS_TFENV := $(shell command -v tfenv;)
HAS_POWERLEVEL10K := $(shell test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && echo "yes" || echo "no")
HAS_SPACESHIP := $(shell test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt && echo "yes" || echo "no")
HAS_AGNOSTER := $(shell test -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/agnoster.zsh-theme && echo "yes" || echo "no")
HAS_FLAMESHOT := $(shell command -v flameshot;)
HAS_GPARTED := $(shell command -v gparted;)

.DEFAULT_GOAL := help

.PHONY: help prepare dockercli zsh PIP CURL VIM UNZIP EKSCTL AWSCLI KUBECTL GCLOUD AZURE MINIKUBE KIND TERRAFORM ANSIBLE install_all docker zsh pip curl vim unzip eksctl awscli kubectl gcloud azure minikube kind terraform ansible python3 java node npm codeclimate helm glasscube mysql mariadb postgres redis mongodb go thanos chef puppet nginx apache mongodb-compass ubuntu-basics gparted
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@if [ "$(HAS_DOCKER)" ]; then \
		echo "  DOCKER             $(GREEN)✅ Docker is installed$(RESET)"; \
	else \
		echo "  DOCKER             $(RED)❌ Docker is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_ZSH)" ]; then \
		echo "  ZSH                $(GREEN)✅ Zsh is installed$(RESET)"; \
	else \
		echo "  ZSH                $(RED)❌ Zsh is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_PYTHON3)" ]; then \
		echo "  PYTHON3            $(GREEN)✅ Python3 is installed$(RESET)"; \
	else \
		echo "  PYTHON3            $(RED)❌ Python3 is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_PIP)" ]; then \
		echo "  PIP                $(GREEN)✅ Pip is installed$(RESET)"; \
	else \
		echo "  PIP                $(RED)❌ Pip is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_CURL)" ]; then \
		echo "  CURL               $(GREEN)✅ Curl is installed$(RESET)"; \
	else \
		echo "  CURL               $(RED)❌ Curl is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_VIM)" ]; then \
		echo "  VIM                $(GREEN)✅ Vim is installed$(RESET)"; \
	else \
		echo "  VIM                $(RED)❌ Vim is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_UNZIP)" ]; then \
		echo "  UNZIP              $(GREEN)✅ Unzip is installed$(RESET)"; \
	else \
		echo "  UNZIP              $(RED)❌ Unzip is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_EKSCTL)" ]; then \
		echo "  EKSCTL             $(GREEN)✅ eksctl is installed$(RESET)"; \
	else \
		echo "  EKSCTL             $(RED)❌ eksctl is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_AWSCLI)" ]; then \
		echo "  AWSCLI             $(GREEN)✅ AWS CLI is installed$(RESET)"; \
	else \
		echo "  AWSCLI             $(RED)❌ AWS CLI is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_KUBECTL)" ]; then \
		echo "  KUBECTL            $(GREEN)✅ kubectl is installed$(RESET)"; \
	else \
		echo "  KUBECTL            $(RED)❌ kubectl is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GCLOUD)" ]; then \
		echo "  GCLOUD             $(GREEN)✅ Google Cloud SDK is installed$(RESET)"; \
	else \
		echo "  GCLOUD             $(RED)❌ Google Cloud SDK is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_AZURE)" ]; then \
		echo "  AZURE              $(GREEN)✅ Azure CLI is installed$(RESET)"; \
	else \
		echo "  AZURE              $(RED)❌ Azure CLI is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_MINIKUBE)" ]; then \
		echo "  MINIKUBE           $(GREEN)✅ Minikube is installed$(RESET)"; \
	else \
		echo "  MINIKUBE           $(RED)❌ Minikube is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_KIND)" ]; then \
		echo "  KIND               $(GREEN)✅ Kind is installed$(RESET)"; \
	else \
		echo "  KIND               $(RED)❌ Kind is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TERRAFORM)" ]; then \
		echo "  TERRAFORM          $(GREEN)✅ Terraform is installed$(RESET)"; \
	else \
		echo "  TERRAFORM          $(RED)❌ Terraform is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_ANSIBLE)" ]; then \
		echo "  ANSIBLE            $(GREEN)✅ Ansible is installed$(RESET)"; \
	else \
		echo "  ANSIBLE            $(RED)❌ Ansible is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_PROMETHEUS)" ]; then \
		echo "  PROMETHEUS         $(GREEN)✅ Prometheus is installed$(RESET)"; \
	else \
		echo "  PROMETHEUS         $(RED)❌ Prometheus is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GRAFANA)" ]; then \
		echo "  GRAFANA            $(GREEN)✅ Grafana is installed$(RESET)"; \
	else \
		echo "  GRAFANA            $(RED)❌ Grafana is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_SONARQUBE)" ]; then \
		echo "  SONARQUBE          $(GREEN)✅ SonarQube is installed$(RESET)"; \
	else \
		echo "  SONARQUBE          $(RED)❌ SonarQube is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_JENKINS)" ]; then \
		echo "  JENKINS            $(GREEN)✅ Jenkins is installed$(RESET)"; \
	else \
		echo "  JENKINS            $(RED)❌ Jenkins is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_CODECLIMATE)" ]; then \
		echo "  CODECLIMATE        $(GREEN)✅ CodeClimate is installed$(RESET)"; \
	else \
		echo "  CODECLIMATE        $(RED)❌ CodeClimate is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_HELM)" ]; then \
		echo "  HELM               $(GREEN)✅ Helm is installed$(RESET)"; \
	else \
		echo "  HELM               $(RED)❌ Helm is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GLASSCUBE)" ]; then \
		echo "  GLASSCUBE          $(GREEN)✅ Glasscube is installed$(RESET)"; \
	else \
		echo "  GLASSCUBE          $(RED)❌ Glasscube is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_MYSQL)" ]; then \
		echo "  MYSQL              $(GREEN)✅ MySQL is installed$(RESET)"; \
	else \
		echo "  MYSQL              $(RED)❌ MySQL is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_MARIADB)" ]; then \
		echo "  MARIADB            $(GREEN)✅ MariaDB is installed$(RESET)"; \
	else \
		echo "  MARIADB            $(RED)❌ MariaDB is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_POSTGRES)" ]; then \
		echo "  POSTGRES           $(GREEN)✅ PostgreSQL is installed$(RESET)"; \
	else \
		echo "  POSTGRES           $(RED)❌ PostgreSQL is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_REDIS)" ]; then \
		echo "  REDIS              $(GREEN)✅ Redis is installed$(RESET)"; \
	else \
		echo "  REDIS              $(RED)❌ Redis is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_MONGODB)" ]; then \
		echo "  MONGODB            $(GREEN)✅ MongoDB is installed$(RESET)"; \
	else \
		echo "  MONGODB            $(RED)❌ MongoDB is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_MONGODB_COMPASS)" ]; then \
		echo "  MONGODB_COMPASS    $(GREEN)✅ MongoDB Compass is installed$(RESET)"; \
	else \
		echo "  MONGODB_COMPASS    $(RED)❌ MongoDB Compass is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GO)" ]; then \
		echo "  GO                 $(GREEN)✅ Go is installed$(RESET)"; \
	else \
		echo "  GO                 $(RED)❌ Go is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_THANOS)" ]; then \
		echo "  THANOS             $(GREEN)✅ Thanos is installed$(RESET)"; \
	else \
		echo "  THANOS             $(RED)❌ Thanos is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_CHEF)" ]; then \
		echo "  CHEF               $(GREEN)✅ Chef is installed$(RESET)"; \
	else \
		echo "  CHEF               $(RED)❌ Chef is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_PUPPET)" ]; then \
		echo "  PUPPET             $(GREEN)✅ Puppet is installed$(RESET)"; \
	else \
		echo "  PUPPET             $(RED)❌ Puppet is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_NGINX)" ]; then \
		echo "  NGINX              $(GREEN)✅ Nginx is installed$(RESET)"; \
	else \
		echo "  NGINX              $(RED)❌ Nginx is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_APACHE)" ]; then \
		echo "  APACHE             $(GREEN)✅ Apache is installed$(RESET)"; \
	else \
		echo "  APACHE             $(RED)❌ Apache is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GIT)" ]; then \
		echo "  GIT                $(GREEN)✅ Git is installed$(RESET)"; \
	else \
		echo "  GIT                $(RED)❌ Git is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_HTOP)" ]; then \
		echo "  HTOP               $(GREEN)✅ Htop is installed$(RESET)"; \
	else \
		echo "  HTOP               $(RED)❌ Htop is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TMUX)" ]; then \
		echo "  TMUX               $(GREEN)✅ Tmux is installed$(RESET)"; \
	else \
		echo "  TMUX               $(RED)❌ Tmux is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TREE)" ]; then \
		echo "  TREE               $(GREEN)✅ Tree is installed$(RESET)"; \
	else \
		echo "  TREE               $(RED)❌ Tree is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_NET_TOOLS)" ]; then \
		echo "  NET_TOOLS          $(GREEN)✅ Net-tools is installed$(RESET)"; \
	else \
		echo "  NET_TOOLS          $(RED)❌ Net-tools is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_BUILD_ESSENTIAL)" ]; then \
		echo "  BUILD_ESSENTIAL    $(GREEN)✅ Build Essential is installed$(RESET)"; \
	else \
		echo "  BUILD_ESSENTIAL    $(RED)❌ Build Essential is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_OPENSSH)" ]; then \
		echo "  OPENSSH            $(GREEN)✅ OpenSSH is installed$(RESET)"; \
	else \
		echo "  OPENSSH            $(RED)❌ OpenSSH is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_WGET)" ]; then \
		echo "  WGET               $(GREEN)✅ Wget is installed$(RESET)"; \
	else \
		echo "  WGET               $(RED)❌ Wget is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_SNAP)" ]; then \
		echo "  SNAP               $(GREEN)✅ Snap is installed$(RESET)"; \
	else \
		echo "  SNAP               $(RED)❌ Snap is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_CHROME)" ]; then \
		echo "  CHROME             $(GREEN)✅ Google Chrome is installed$(RESET)"; \
	else \
		echo "  CHROME             $(RED)❌ Google Chrome is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_FIREFOX)" ]; then \
		echo "  FIREFOX            $(GREEN)✅ Firefox is installed$(RESET)"; \
	else \
		echo "  FIREFOX            $(RED)❌ Firefox is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TERRAGRUNT)" ]; then \
		echo "  TERRAGRUNT         $(GREEN)✅ Terragrunt is installed$(RESET)"; \
	else \
		echo "  TERRAGRUNT         $(RED)❌ Terragrunt is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TFSEC)" ]; then \
		echo "  TFSEC              $(GREEN)✅ TFSec is installed$(RESET)"; \
	else \
		echo "  TFSEC              $(RED)❌ TFSec is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TFLINT)" ]; then \
		echo "  TFLINT             $(GREEN)✅ TFLint is installed$(RESET)"; \
	else \
		echo "  TFLINT             $(RED)❌ TFLint is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_TFENV)" ]; then \
		echo "  TFENV              $(GREEN)✅ TFEnv is installed$(RESET)"; \
	else \
		echo "  TFENV              $(RED)❌ TFEnv is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_POWERLEVEL10K)" ]; then \
		echo "  POWERLEVEL10K      $(GREEN)✅ Powerlevel10k is installed$(RESET)"; \
	else \
		echo "  POWERLEVEL10K      $(RED)❌ Powerlevel10k is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_SPACESHIP)" ]; then \
		echo "  SPACESHIP          $(GREEN)✅ Spaceship is installed$(RESET)"; \
	else \
		echo "  SPACESHIP          $(RED)❌ Spaceship is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_AGNOSTER)" ]; then \
		echo "  AGNOSTER           $(GREEN)✅ Agnoster is installed$(RESET)"; \
	else \
		echo "  AGNOSTER           $(RED)❌ Agnoster is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_FLAMESHOT)" ]; then \
		echo "  FLAMESHOT          $(GREEN)✅ Flameshot is installed$(RESET)"; \
	else \
		echo "  FLAMESHOT          $(RED)❌ Flameshot is not installed$(RESET)"; \
	fi
	@if [ "$(HAS_GPARTED)" ]; then \
		echo "  GPARTED            $(GREEN)✅ GParted is installed$(RESET)"; \
	else \
		echo "  GPARTED            $(RED)❌ GParted is not installed$(RESET)"; \
	fi

.PHONY: install_all
install_all:
	@echo "$(CYAN)Checking and installing required tools...$(RESET)"
	
	@if ! command -v docker &> /dev/null; then \
		echo "$(YELLOW)Installing Docker...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable" && \
		sudo apt-get update && \
		sudo apt-get install -y docker-ce && \
		sudo usermod -aG docker $${USER}; \
	fi
	
	@if ! command -v zsh &> /dev/null; then \
		echo "$(YELLOW)Installing Zsh...$(RESET)"; \
		sudo apt-get install -y zsh; \
	fi
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		echo "$(YELLOW)Installing Oh My Zsh...$(RESET)"; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
	fi
	
	@if ! command -v pip &> /dev/null; then \
		echo "$(YELLOW)Installing Pip...$(RESET)"; \
		sudo apt-get install -y python3-pip; \
	fi
	
	@if ! command -v curl &> /dev/null; then \
		echo "$(YELLOW)Installing Curl...$(RESET)"; \
		sudo apt-get install -y curl; \
	fi
	
	@if ! command -v vim &> /dev/null; then \
		echo "$(YELLOW)Installing Vim...$(RESET)"; \
		sudo apt-get install -y vim; \
	fi
	
	@if ! command -v unzip &> /dev/null; then \
		echo "$(YELLOW)Installing Unzip...$(RESET)"; \
		sudo apt-get install -y unzip; \
	fi
	
	@if ! command -v eksctl &> /dev/null; then \
		echo "$(YELLOW)Installing eksctl...$(RESET)"; \
		curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
		sudo mv /tmp/eksctl /usr/local/bin; \
	fi
	
	@if ! command -v aws &> /dev/null; then \
		echo "$(YELLOW)Installing AWS CLI...$(RESET)"; \
		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
		unzip awscliv2.zip && \
		sudo ./aws/install && \
		rm -rf aws awscliv2.zip; \
	fi
	
	@if ! command -v kubectl &> /dev/null; then \
		echo "$(YELLOW)Installing kubectl...$(RESET)"; \
		curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
		sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
		rm kubectl; \
	fi
	
	@if ! command -v gcloud &> /dev/null; then \
		echo "$(YELLOW)Installing Google Cloud SDK...$(RESET)"; \
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
		sudo apt-get update && sudo apt-get install google-cloud-sdk; \
	fi
	
	@if ! command -v az &> /dev/null; then \
		echo "$(YELLOW)Installing Azure CLI...$(RESET)"; \
		curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash; \
	fi
	
	@if ! command -v minikube &> /dev/null; then \
		echo "$(YELLOW)Installing Minikube...$(RESET)"; \
		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
		sudo install minikube-linux-amd64 /usr/local/bin/minikube; \
	fi
	
	@if ! command -v kind &> /dev/null; then \
		echo "$(YELLOW)Installing Kind...$(RESET)"; \
		curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 && \
		chmod +x ./kind && \
		sudo mv ./kind /usr/local/bin/kind; \
	fi
	
	@if ! command -v terraform &> /dev/null; then \
		echo "$(YELLOW)Installing Terraform...$(RESET)"; \
		sudo apt-get update && sudo apt-get install -y gnupg software-properties-common && \
		wget -O- https://apt.releases.hashicorp.com/gpg | \
		gpg --dearmor | \
		sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
		gpg --no-default-keyring \
		--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
		--fingerprint && \
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
		https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
		sudo tee /etc/apt/sources.list.d/hashicorp.list && \
		sudo apt update && \
		sudo apt-get install terraform -y; \
		echo "$(GREEN)Terraform installed successfully.$(RESET)"; \
		echo "$(YELLOW)Terraform version:$(RESET)"; \
		terraform version; \
	else \
		echo "$(GREEN)Terraform is already installed.$(RESET)"; \
		echo "$(YELLOW)Terraform version:$(RESET)"; \
		terraform version; \
	fi
	
	@if ! command -v ansible &> /dev/null; then \
		echo "$(YELLOW)Installing Ansible...$(RESET)"; \
		sudo apt update && \
		sudo apt install software-properties-common && \
		sudo add-apt-repository --yes --update ppa:ansible/ansible && \
		sudo apt install ansible; \
		echo "$(GREEN)Ansible installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Ansible is already installed.$(RESET)"; \
	fi
	
	@if ! command -v python3 &> /dev/null; then \
		echo "$(YELLOW)Installing Python3...$(RESET)"; \
			sudo apt-get update && \
			sudo apt-get install -y python3; \
		echo "$(GREEN)Python3 installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Python3 is already installed.$(RESET)"; \
	fi
	
	@if ! command -v nvm &> /dev/null; then \
		echo "$(YELLOW)Installing NVM...$(RESET)"; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash; \
		export NVM_DIR="$$HOME/.nvm"; \
		[ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh"; \
	fi
	
	@if ! command -v kubeadm &> /dev/null; then \
		echo "$(YELLOW)Installing Kubeadm...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apt-transport-https ca-certificates curl && \
		sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
		echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
		sudo apt-get update && \
		sudo apt-get install -y kubeadm; \
	fi
	
	@if ! command -v prometheus &> /dev/null; then \
		echo "$(YELLOW)Installing Prometheus...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y prometheus && \
		sudo systemctl enable prometheus && \
		sudo systemctl start prometheus; \
		echo "$(GREEN)Prometheus installed successfully.$(RESET)"; \
		echo "$(YELLOW)Prometheus is running at http://localhost:9090$(RESET)"; \
	else \
		echo "$(GREEN)Prometheus is already installed.$(RESET)"; \
	fi
	
	@if ! command -v grafana-server &> /dev/null; then \
		echo "$(YELLOW)Installing Grafana...$(RESET)"; \
		sudo apt-get install -y software-properties-common wget && \
		sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key && \
		echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list && \
		sudo apt-get update && \
		sudo apt-get install -y grafana && \
		sudo systemctl enable grafana-server && \
		sudo systemctl start grafana-server; \
		echo "$(GREEN)Grafana installed successfully.$(RESET)"; \
		echo "$(YELLOW)Grafana is running at http://localhost:3000$(RESET)"; \
		echo "$(YELLOW)Default credentials: admin/admin$(RESET)"; \
	else \
		echo "$(GREEN)Grafana is already installed.$(RESET)"; \
	fi
	
	@if ! command -v sonar-scanner &> /dev/null; then \
		echo "$(YELLOW)Installing SonarQube...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y unzip openjdk-11-jdk && \
		wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip && \
		unzip sonar-scanner-cli-4.7.0.2747-linux.zip && \
		sudo mv sonar-scanner-4.7.0.2747-linux /opt/sonar-scanner && \
		sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
		rm sonar-scanner-cli-4.7.0.2747-linux.zip; \
		echo "$(GREEN)SonarQube Scanner installed successfully.$(RESET)"; \
	fi
	
	@if ! command -v jenkins &> /dev/null; then \
		echo "$(YELLOW)Installing Jenkins...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y openjdk-11-jdk && \
		wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - && \
		sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
		sudo apt-get update && \
		sudo apt-get install -y jenkins && \
		sudo systemctl enable jenkins && \
		sudo systemctl start jenkins; \
		echo "$(GREEN)Jenkins installed successfully.$(RESET)"; \
		echo "$(YELLOW)Jenkins is running at http://localhost:8080$(RESET)"; \
		echo "$(YELLOW)Initial admin password: $(RESET)"; \
		sudo cat /var/lib/jenkins/secrets/initialAdminPassword; \
	fi
	
	@if ! command -v java &> /dev/null || ! command -v javac &> /dev/null; then \
		echo "$(YELLOW)Installing Java JDK...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y default-jdk default-jre && \
		echo "$(GREEN)Java JDK installed successfully.$(RESET)"; \
		echo "$(YELLOW)Java version:$(RESET)"; \
		java -version; \
		echo "$(YELLOW)Java compiler version:$(RESET)"; \
		javac -version; \
	else \
		echo "$(GREEN)Java is already installed.$(RESET)"; \
		echo "$(YELLOW)Java version:$(RESET)"; \
		java -version; \
		echo "$(YELLOW)Java compiler version:$(RESET)"; \
		javac -version; \
	fi
	
	@if ! command -v node &> /dev/null; then \
		echo "$(YELLOW)Installing Node.js...$(RESET)"; \
		curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
		sudo apt-get install -y nodejs; \
	fi
	
	@if ! command -v npm &> /dev/null; then \
		echo "$(YELLOW)Installing NPM...$(RESET)"; \
		sudo apt-get install -y npm; \
	fi
	
	@if ! command -v codeclimate &> /dev/null; then \
		echo "$(YELLOW)Installing CodeClimate...$(RESET)"; \
		curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz && \
		cd codeclimate-master && \
		sudo make install && \
		cd .. && rm -rf codeclimate-master && \
		sudo codeclimate engines:install; \
	fi
	
	@if ! command -v helm &> /dev/null; then \
		echo "$(YELLOW)Installing Helm...$(RESET)"; \
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null && \
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
		sudo apt-get update && \
		sudo apt-get install -y helm; \
	fi
	
	@if ! command -v glasscube &> /dev/null; then \
		echo "$(YELLOW)Installing Glasscube...$(RESET)"; \
		curl -fsSL https://raw.githubusercontent.com/glasscube/glasscube/main/install.sh | sudo bash; \
	fi
	
	@if ! command -v mysql &> /dev/null; then \
		echo "$(YELLOW)Installing MySQL...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y mysql-server && \
		sudo systemctl enable mysql && \
		sudo systemctl start mysql; \
		echo "$(GREEN)MySQL installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'sudo mysql_secure_installation' to secure your installation$(RESET)"; \
	else \
		echo "$(GREEN)MySQL is already installed.$(RESET)"; \
	fi
	
	@if ! command -v mariadb &> /dev/null; then \
		echo "$(YELLOW)Installing MariaDB...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y mariadb-server && \
		sudo systemctl enable mariadb && \
		sudo systemctl start mariadb; \
		echo "$(GREEN)MariaDB installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'sudo mysql_secure_installation' to secure your installation$(RESET)"; \
	else \
		echo "$(GREEN)MariaDB is already installed.$(RESET)"; \
	fi
	
	@if ! command -v psql &> /dev/null; then \
		echo "$(YELLOW)Installing PostgreSQL...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y postgresql postgresql-contrib && \
		sudo systemctl enable postgresql && \
		sudo systemctl start postgresql; \
		echo "$(GREEN)PostgreSQL installed successfully.$(RESET)"; \
		echo "$(YELLOW)Default superuser: postgres$(RESET)"; \
	else \
		echo "$(GREEN)PostgreSQL is already installed.$(RESET)"; \
	fi
	
	@if ! command -v redis-server &> /dev/null; then \
		echo "$(YELLOW)Installing Redis...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y redis-server && \
		sudo systemctl enable redis-server && \
		sudo systemctl start redis-server; \
		echo "$(GREEN)Redis installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Redis is already installed.$(RESET)"; \
	fi
	
	@if ! command -v mongod &> /dev/null; then \
		echo "$(YELLOW)Installing MongoDB...$(RESET)"; \
		wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add - && \
		echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $$(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
		sudo apt-get update && \
		sudo apt-get install -y mongodb-org && \
		sudo systemctl enable mongod && \
		sudo systemctl start mongod; \
		echo "$(GREEN)MongoDB installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)MongoDB is already installed.$(RESET)"; \
	fi
	
	@if ! command -v go &> /dev/null; then \
		echo "$(YELLOW)Installing Go...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y golang-go; \
		echo "$(GREEN)Go installed successfully.$(RESET)"; \
		echo "$(YELLOW)Go version:$(RESET)"; \
		go version; \
	else \
		echo "$(GREEN)Go is already installed.$(RESET)"; \
		echo "$(YELLOW)Go version:$(RESET)"; \
		go version; \
	fi
	
	@if ! command -v thanos &> /dev/null; then \
		echo "$(YELLOW)Installing Thanos...$(RESET)"; \
		wget https://github.com/thanos-io/thanos/releases/latest/download/thanos-$$(uname -s)-$$(uname -m).tar.gz && \
		tar -xvf thanos-$$(uname -s)-$$(uname -m).tar.gz && \
		sudo mv thanos /usr/local/bin/ && \
		rm thanos-$$(uname -s)-$$(uname -m).tar.gz; \
		echo "$(GREEN)Thanos installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Thanos is already installed.$(RESET)"; \
	fi
	
	@if ! command -v chef &> /dev/null; then \
		echo "$(YELLOW)Installing Chef...$(RESET)"; \
		curl -L https://omnitruck.chef.io/install.sh | sudo bash; \
		echo "$(GREEN)Chef installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Chef is already installed.$(RESET)"; \
	fi
	
	@if ! command -v puppet &> /dev/null; then \
		echo "$(YELLOW)Installing Puppet...$(RESET)"; \
		wget https://apt.puppetlabs.com/puppet7-release-$$(lsb_release -cs).deb && \
		sudo dpkg -i puppet7-release-$$(lsb_release -cs).deb && \
		sudo apt-get update && \
		sudo apt-get install -y puppet-agent && \
		rm puppet7-release-$$(lsb_release -cs).deb; \
		echo "$(GREEN)Puppet installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Puppet is already installed.$(RESET)"; \
	fi
	
	@if ! command -v nginx &> /dev/null; then \
		echo "$(YELLOW)Installing Nginx...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y nginx && \
		sudo systemctl enable nginx && \
		sudo systemctl start nginx; \
		echo "$(GREEN)Nginx installed successfully.$(RESET)"; \
		echo "$(YELLOW)Nginx is running at http://localhost:80$(RESET)"; \
	else \
		echo "$(GREEN)Nginx is already installed.$(RESET)"; \
	fi
	
	@if ! command -v apache2 &> /dev/null; then \
		echo "$(YELLOW)Installing Apache...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apache2 && \
		sudo systemctl enable apache2 && \
		sudo systemctl start apache2; \
		echo "$(GREEN)Apache installed successfully.$(RESET)"; \
		echo "$(YELLOW)Apache is running at http://localhost:80$(RESET)"; \
	else \
		echo "$(GREEN)Apache is already installed.$(RESET)"; \
	fi
	
	@if ! command -v mongodb-compass &> /dev/null; then \
		echo "$(YELLOW)Installing MongoDB Compass...$(RESET)"; \
		wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb && \
		sudo dpkg -i mongodb-compass_1.40.4_amd64.deb && \
		rm mongodb-compass_1.40.4_amd64.deb; \
	fi
	
	@echo "$(GREEN)All tools have been checked and installed if necessary.$(RESET)"

# Add these new targets after the existing individual check targets

docker:
	@if ! command -v docker &> /dev/null; then \
		echo "$(YELLOW)Installing Docker...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable" && \
		sudo apt-get update && \
		sudo apt-get install -y docker-ce && \
		sudo usermod -aG docker $${USER}; \
		echo "$(GREEN)Docker installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Docker is already installed.$(RESET)"; \
	fi

zsh:
	@if ! command -v zsh &> /dev/null; then \
		echo "$(YELLOW)Installing Zsh...$(RESET)"; \
		sudo apt-get install -y zsh; \
		echo "$(GREEN)Zsh installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Zsh is already installed.$(RESET)"; \
	fi
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		echo "$(YELLOW)Installing Oh My Zsh...$(RESET)"; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
		echo "$(GREEN)Oh My Zsh installed successfully.$(RESET)"; \
		echo "$(YELLOW)To use Zsh as your default shell, run: chsh -s $$(which zsh)$(RESET)"; \
	else \
		echo "$(GREEN)Oh My Zsh is already installed.$(RESET)"; \
	fi

pip:
	@if ! command -v pip &> /dev/null; then \
		echo "$(YELLOW)Installing Pip...$(RESET)"; \
		sudo apt-get install -y python3-pip; \
		echo "$(GREEN)Pip installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Pip is already installed.$(RESET)"; \
	fi

curl:
	@if ! command -v curl &> /dev/null; then \
		echo "$(YELLOW)Installing Curl...$(RESET)"; \
		sudo apt-get install -y curl; \
		echo "$(GREEN)Curl installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Curl is already installed.$(RESET)"; \
	fi

vim:
	@if ! command -v vim &> /dev/null; then \
		echo "$(YELLOW)Installing Vim...$(RESET)"; \
		sudo apt-get install -y vim; \
		echo "$(GREEN)Vim installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Vim is already installed.$(RESET)"; \
	fi

unzip:
	@if ! command -v unzip &> /dev/null; then \
		echo "$(YELLOW)Installing Unzip...$(RESET)"; \
		sudo apt-get install -y unzip; \
		echo "$(GREEN)Unzip installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Unzip is already installed.$(RESET)"; \
	fi

eksctl:
	@if ! command -v eksctl &> /dev/null; then \
		echo "$(YELLOW)Installing eksctl...$(RESET)"; \
		curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
		sudo mv /tmp/eksctl /usr/local/bin; \
		echo "$(GREEN)eksctl installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)eksctl is already installed.$(RESET)"; \
	fi

awscli:
	@if ! command -v aws &> /dev/null; then \
		echo "$(YELLOW)Installing AWS CLI...$(RESET)"; \
			curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
		unzip awscliv2.zip && \
		sudo ./aws/install && \
		rm -rf aws awscliv2.zip; \
		echo "$(GREEN)AWS CLI installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)AWS CLI is already installed.$(RESET)"; \
	fi

kubectl:
	@if ! command -v kubectl &> /dev/null; then \
		echo "$(YELLOW)Installing kubectl...$(RESET)"; \
		curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
		sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
		rm kubectl; \
		echo "$(GREEN)kubectl installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)kubectl is already installed.$(RESET)"; \
	fi

gcloud:
	@if ! command -v gcloud &> /dev/null; then \
		echo "$(YELLOW)Installing Google Cloud SDK...$(RESET)"; \
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
		sudo apt-get update && sudo apt-get install -y google-cloud-sdk; \
		echo "$(GREEN)Google Cloud SDK installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Google Cloud SDK is already installed.$(RESET)"; \
	fi

azure:
	@if ! command -v az &> /dev/null; then \
		echo "$(YELLOW)Installing Azure CLI...$(RESET)"; \
		curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash; \
		echo "$(GREEN)Azure CLI installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Azure CLI is already installed.$(RESET)"; \
	fi

minikube:
	@if ! command -v minikube &> /dev/null; then \
		echo "$(YELLOW)Installing Minikube...$(RESET)"; \
		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
		sudo install minikube-linux-amd64 /usr/local/bin/minikube; \
		echo "$(GREEN)Minikube installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Minikube is already installed.$(RESET)"; \
	fi

kind:
	@if ! command -v kind &> /dev/null; then \
		echo "$(YELLOW)Installing Kind...$(RESET)"; \
		curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 && \
		chmod +x ./kind && \
		sudo mv ./kind /usr/local/bin/kind; \
		echo "$(GREEN)Kind installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Kind is already installed.$(RESET)"; \
	fi


ansible:
	@if ! command -v ansible &> /dev/null; then \
		echo "$(YELLOW)Installing Ansible...$(RESET)"; \
		sudo apt update && \
		sudo apt install software-properties-common && \
		sudo add-apt-repository --yes --update ppa:ansible/ansible && \
		sudo apt install ansible; \
		echo "$(GREEN)Ansible installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Ansible is already installed.$(RESET)"; \
	fi
terraform:
	@if ! command -v terraform &> /dev/null; then \
		echo "$(YELLOW)Installing Terraform...$(RESET)"; \
		sudo apt-get update && sudo apt-get install -y gnupg software-properties-common && \
		wget -O- https://apt.releases.hashicorp.com/gpg | \
		gpg --dearmor | \
		sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
		gpg --no-default-keyring \
		--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
		--fingerprint && \
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
		https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
		sudo tee /etc/apt/sources.list.d/hashicorp.list && \
		sudo apt update && \
		sudo apt-get install terraform -y; \
		echo "$(GREEN)Terraform installed successfully.$(RESET)"; \
		echo "$(YELLOW)Terraform version:$(RESET)"; \
		terraform version; \
	else \
		echo "$(GREEN)Terraform is already installed.$(RESET)"; \
		echo "$(YELLOW)Terraform version:$(RESET)"; \
		terraform version; \
	fi

chrome:
	sudo apt install -y google-chrome-stable

brave:
	sudo apt install -y brave-browser

python3:
	@if ! command -v python3 &> /dev/null; then \
		echo "$(YELLOW)Installing Python3...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y python3; \
		echo "$(GREEN)Python3 installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Python3 is already installed.$(RESET)"; \
	fi

nvm:
	@if ! command -v nvm &> /dev/null; then \
		echo "$(YELLOW)Installing NVM...$(RESET)"; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash; \
		export NVM_DIR="$$HOME/.nvm"; \
		[ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh"; \
		echo "$(GREEN)NVM installed successfully.$(RESET)"; \
		echo "$(YELLOW)Please restart your terminal or run: source ~/.bashrc$(RESET)"; \
	else \
		echo "$(GREEN)NVM is already installed.$(RESET)"; \
	fi

kubeadm:
	@if ! command -v kubeadm &> /dev/null; then \
		echo "$(YELLOW)Installing Kubeadm...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apt-transport-https ca-certificates curl && \
		sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
		echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
		sudo apt-get update && \
		sudo apt-get install -y kubeadm; \
		echo "$(GREEN)Kubeadm installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Kubeadm is already installed.$(RESET)"; \
	fi

prometheus:
	@if ! command -v prometheus &> /dev/null; then \
		echo "$(YELLOW)Installing Prometheus...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y prometheus && \
		sudo systemctl enable prometheus && \
		sudo systemctl start prometheus; \
		echo "$(GREEN)Prometheus installed successfully.$(RESET)"; \
		echo "$(YELLOW)Prometheus is running at http://localhost:9090$(RESET)"; \
	else \
		echo "$(GREEN)Prometheus is already installed.$(RESET)"; \
	fi

grafana:
	@if ! command -v grafana-server &> /dev/null; then \
		echo "$(YELLOW)Installing Grafana...$(RESET)"; \
		sudo apt-get install -y software-properties-common wget && \
		sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key && \
		echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list && \
		sudo apt-get update && \
		sudo apt-get install -y grafana && \
		sudo systemctl enable grafana-server && \
		sudo systemctl start grafana-server; \
		echo "$(GREEN)Grafana installed successfully.$(RESET)"; \
		echo "$(YELLOW)Grafana is running at http://localhost:3000$(RESET)"; \
		echo "$(YELLOW)Default credentials: admin/admin$(RESET)"; \
	else \
		echo "$(GREEN)Grafana is already installed.$(RESET)"; \
	fi

sonarqube:
	@if ! command -v sonar-scanner &> /dev/null; then \
		echo "$(YELLOW)Installing SonarQube...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y unzip openjdk-11-jdk && \
		wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip && \
		unzip sonar-scanner-cli-4.7.0.2747-linux.zip && \
		sudo mv sonar-scanner-4.7.0.2747-linux /opt/sonar-scanner && \
		sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
		rm sonar-scanner-cli-4.7.0.2747-linux.zip; \
		echo "$(GREEN)SonarQube Scanner installed successfully.$(RESET)"; \
		echo "$(YELLOW)Configure SonarQube server at http://localhost:9000$(RESET)"; \
		echo "$(YELLOW)Default credentials: admin/admin$(RESET)"; \
	else \
		echo "$(GREEN)SonarQube Scanner is already installed.$(RESET)"; \
	fi

jenkins:
	@if ! command -v jenkins &> /dev/null; then \
		echo "$(YELLOW)Installing Jenkins...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y openjdk-11-jdk && \
		wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - && \
		sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
		sudo apt-get update && \
		sudo apt-get install -y jenkins && \
		sudo systemctl enable jenkins && \
		sudo systemctl start jenkins; \
		echo "$(GREEN)Jenkins installed successfully.$(RESET)"; \
		echo "$(YELLOW)Jenkins is running at http://localhost:8080$(RESET)"; \
		echo "$(YELLOW)Initial admin password: $(RESET)"; \
		sudo cat /var/lib/jenkins/secrets/initialAdminPassword; \
	else \
		echo "$(GREEN)Jenkins is already installed.$(RESET)"; \
	fi

java:
	@if ! command -v java &> /dev/null || ! command -v javac &> /dev/null; then \
		echo "$(YELLOW)Installing Java JDK...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y default-jdk default-jre && \
		echo "$(GREEN)Java JDK installed successfully.$(RESET)"; \
		echo "$(YELLOW)Java version:$(RESET)"; \
		java -version; \
		echo "$(YELLOW)Java compiler version:$(RESET)"; \
		javac -version; \
	else \
		echo "$(GREEN)Java is already installed.$(RESET)"; \
		echo "$(YELLOW)Java version:$(RESET)"; \
		java -version; \
		echo "$(YELLOW)Java compiler version:$(RESET)"; \
		javac -version; \
	fi

node:
	@if ! command -v node &> /dev/null; then \
		echo "$(YELLOW)Installing Node.js...$(RESET)"; \
		curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
		sudo apt-get install -y nodejs; \
	fi

npm:
	@if ! command -v npm &> /dev/null; then \
		echo "$(YELLOW)Installing NPM...$(RESET)"; \
		sudo apt-get install -y npm; \
	fi

codeclimate:
	@if ! command -v codeclimate &> /dev/null; then \
		echo "$(YELLOW)Installing CodeClimate...$(RESET)"; \
		curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz && \
		cd codeclimate-master && \
		sudo make install && \
		cd .. && rm -rf codeclimate-master && \
		sudo codeclimate engines:install; \
	fi

helm:
	@if ! command -v helm &> /dev/null; then \
		echo "$(YELLOW)Installing Helm...$(RESET)"; \
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null && \
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
		sudo apt-get update && \
		sudo apt-get install -y helm; \
	fi

glasscube:
	@if ! command -v glasscube &> /dev/null; then \
		echo "$(YELLOW)Installing Glasscube...$(RESET)"; \
			curl -fsSL https://raw.githubusercontent.com/glasscube/glasscube/main/install.sh | sudo bash; \
		echo "$(GREEN)Glasscube installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'glasscube --help' for usage information$(RESET)"; \
	else \
		echo "$(GREEN)Glasscube is already installed.$(RESET)"; \
	fi

mysql:
	@if ! command -v mysql &> /dev/null; then \
		echo "$(YELLOW)Installing MySQL...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y mysql-server && \
		sudo systemctl enable mysql && \
		sudo systemctl start mysql; \
		echo "$(GREEN)MySQL installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'sudo mysql_secure_installation' to secure your installation$(RESET)"; \
	else \
		echo "$(GREEN)MySQL is already installed.$(RESET)"; \
	fi

mariadb:
	@if ! command -v mariadb &> /dev/null; then \
		echo "$(YELLOW)Installing MariaDB...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y mariadb-server && \
		sudo systemctl enable mariadb && \
		sudo systemctl start mariadb; \
		echo "$(GREEN)MariaDB installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'sudo mysql_secure_installation' to secure your installation$(RESET)"; \
	else \
		echo "$(GREEN)MariaDB is already installed.$(RESET)"; \
	fi

postgres:
	@if ! command -v psql &> /dev/null; then \
		echo "$(YELLOW)Installing PostgreSQL...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y postgresql postgresql-contrib && \
		sudo systemctl enable postgresql && \
		sudo systemctl start postgresql; \
		echo "$(GREEN)PostgreSQL installed successfully.$(RESET)"; \
		echo "$(YELLOW)Default superuser: postgres$(RESET)"; \
	else \
		echo "$(GREEN)PostgreSQL is already installed.$(RESET)"; \
	fi

redis:
	@if ! command -v redis-server &> /dev/null; then \
		echo "$(YELLOW)Installing Redis...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y redis-server && \
		sudo systemctl enable redis-server && \
		sudo systemctl start redis-server; \
		echo "$(GREEN)Redis installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Redis is already installed.$(RESET)"; \
	fi

mongodb:
	@if ! command -v mongod &> /dev/null; then \
		echo "$(YELLOW)Installing MongoDB...$(RESET)"; \
		wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add - && \
		echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $$(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
		sudo apt-get update && \
		sudo apt-get install -y mongodb-org && \
		sudo systemctl enable mongod && \
		sudo systemctl start mongod; \
		echo "$(GREEN)MongoDB installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)MongoDB is already installed.$(RESET)"; \
	fi

go:
	@if ! command -v go &> /dev/null; then \
		echo "$(YELLOW)Installing Go...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y golang-go; \
		echo "$(GREEN)Go installed successfully.$(RESET)"; \
		echo "$(YELLOW)Go version:$(RESET)"; \
		go version; \
	else \
		echo "$(GREEN)Go is already installed.$(RESET)"; \
		echo "$(YELLOW)Go version:$(RESET)"; \
		go version; \
	fi

thanos:
	@if ! command -v thanos &> /dev/null; then \
		echo "$(YELLOW)Installing Thanos...$(RESET)"; \
		wget https://github.com/thanos-io/thanos/releases/latest/download/thanos-$$(uname -s)-$$(uname -m).tar.gz && \
		tar -xvf thanos-$$(uname -s)-$$(uname -m).tar.gz && \
		sudo mv thanos /usr/local/bin/ && \
		rm thanos-$$(uname -s)-$$(uname -m).tar.gz; \
		echo "$(GREEN)Thanos installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Thanos is already installed.$(RESET)"; \
	fi

chef:
	@if ! command -v chef &> /dev/null; then \
		echo "$(YELLOW)Installing Chef...$(RESET)"; \
		curl -L https://omnitruck.chef.io/install.sh | sudo bash; \
		echo "$(GREEN)Chef installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Chef is already installed.$(RESET)"; \
	fi

puppet:
	@if ! command -v puppet &> /dev/null; then \
		echo "$(YELLOW)Installing Puppet...$(RESET)"; \
		wget https://apt.puppetlabs.com/puppet7-release-$$(lsb_release -cs).deb && \
		sudo dpkg -i puppet7-release-$$(lsb_release -cs).deb && \
		sudo apt-get update && \
		sudo apt-get install -y puppet-agent && \
		rm puppet7-release-$$(lsb_release -cs).deb; \
		echo "$(GREEN)Puppet installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Puppet is already installed.$(RESET)"; \
	fi

nginx:
	@if ! command -v nginx &> /dev/null; then \
		echo "$(YELLOW)Installing Nginx...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y nginx && \
		sudo systemctl enable nginx && \
		sudo systemctl start nginx; \
		echo "$(GREEN)Nginx installed successfully.$(RESET)"; \
		echo "$(YELLOW)Nginx is running at http://localhost:80$(RESET)"; \
	else \
		echo "$(GREEN)Nginx is already installed.$(RESET)"; \
	fi

apache:
	@if ! command -v apache2 &> /dev/null; then \
		echo "$(YELLOW)Installing Apache...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y apache2 && \
		sudo systemctl enable apache2 && \
		sudo systemctl start apache2; \
		echo "$(GREEN)Apache installed successfully.$(RESET)"; \
		echo "$(YELLOW)Apache is running at http://localhost:80$(RESET)"; \
	else \
		echo "$(GREEN)Apache is already installed.$(RESET)"; \
	fi

mongodb-compass:
	@if ! command -v mongodb-compass &> /dev/null; then \
		echo "$(YELLOW)Installing MongoDB Compass...$(RESET)"; \
		wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb && \
		sudo dpkg -i mongodb-compass_1.40.4_amd64.deb && \
		rm mongodb-compass_1.40.4_amd64.deb; \
	fi

ubuntu-basics:
	@echo "$(CYAN)Installing basic Ubuntu tools...$(RESET)"
	sudo apt-get update
	
	@if ! command -v git &> /dev/null; then \
		echo "$(YELLOW)Installing Git...$(RESET)"; \
		sudo apt-get install -y git; \
	fi
	
	@if ! command -v htop &> /dev/null; then \
		echo "$(YELLOW)Installing Htop...$(RESET)"; \
		sudo apt-get install -y htop; \
	fi
	
	@if ! command -v tmux &> /dev/null; then \
		echo "$(YELLOW)Installing Tmux...$(RESET)"; \
		sudo apt-get install -y tmux; \
	fi
	
	@if ! command -v tree &> /dev/null; then \
		echo "$(YELLOW)Installing Tree...$(RESET)"; \
		sudo apt-get install -y tree; \
	fi
	
	@if ! command -v netstat &> /dev/null; then \
		echo "$(YELLOW)Installing Net-tools...$(RESET)"; \
		sudo apt-get install -y net-tools; \
	fi
	
	@if ! command -v gcc &> /dev/null; then \
		echo "$(YELLOW)Installing Build Essential...$(RESET)"; \
		sudo apt-get install -y build-essential; \
	fi
	
	@if ! command -v ssh &> /dev/null; then \
		echo "$(YELLOW)Installing OpenSSH...$(RESET)"; \
		sudo apt-get install -y openssh-server openssh-client; \
	fi
	
	@if ! command -v wget &> /dev/null; then \
		echo "$(YELLOW)Installing Wget...$(RESET)"; \
		sudo apt-get install -y wget; \
	fi
	
	@if ! command -v snap &> /dev/null; then \
		echo "$(YELLOW)Installing Snap...$(RESET)"; \
		sudo apt-get install -y snapd; \
	fi

	# Install additional useful packages
	sudo apt-get install -y \
		software-properties-common \
		apt-transport-https \
		ca-certificates \
		gnupg \
		lsb-release \
		zip \
		gzip \
		tar \
		nano \
		screen \
		nmap \
		tcpdump \
		iftop \
		htop \
		iotop \
		neofetch \
		tldr \
		jq \
		ncdu \
		dnsutils \
		net-tools \
		iproute2 \
		traceroute \
		whois \
		mtr \
		flameshot \
		gparted

	# Install browsers if not present
	@if ! command -v google-chrome &> /dev/null; then \
		echo "$(YELLOW)Installing Google Chrome...$(RESET)"; \
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
		sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt-get install -f -y && \
		rm google-chrome-stable_current_amd64.deb; \
	fi
	
	@if ! command -v firefox &> /dev/null; then \
		echo "$(YELLOW)Installing Firefox...$(RESET)"; \
		sudo apt-get install -y firefox; \
	fi

	@echo "$(GREEN)Basic Ubuntu tools installed successfully.$(RESET)"

terragrunt:
	@if ! command -v terragrunt &> /dev/null; then \
		echo "$(YELLOW)Installing Terragrunt...$(RESET)"; \
		TERRAGRUNT_VERSION=$$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | grep tag_name | cut -d '"' -f 4) && \
		sudo wget -O /usr/local/bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/$$TERRAGRUNT_VERSION/terragrunt_linux_amd64" && \
		sudo chmod +x /usr/local/bin/terragrunt; \
		echo "$(GREEN)Terragrunt installed successfully.$(RESET)"; \
		echo "$(YELLOW)Terragrunt version:$(RESET)"; \
		terragrunt --version; \
	else \
		echo "$(GREEN)Terragrunt is already installed.$(RESET)"; \
		echo "$(YELLOW)Terragrunt version:$(RESET)"; \
		terragrunt --version; \
	fi

tfsec:
	@if ! command -v tfsec &> /dev/null; then \
		echo "$(YELLOW)Installing TFSec...$(RESET)"; \
		sudo curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash && \
		sudo mv tfsec /usr/local/bin/; \
		echo "$(GREEN)TFSec installed successfully.$(RESET)"; \
		echo "$(YELLOW)TFSec version:$(RESET)"; \
		tfsec --version; \
	else \
		echo "$(GREEN)TFSec is already installed.$(RESET)"; \
		echo "$(YELLOW)TFSec version:$(RESET)"; \
		tfsec --version; \
	fi

tflint:
	@if ! command -v tflint &> /dev/null; then \
		echo "$(YELLOW)Installing TFLint...$(RESET)"; \
		curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash; \
		echo "$(GREEN)TFLint installed successfully.$(RESET)"; \
		echo "$(YELLOW)TFLint version:$(RESET)"; \
		tflint --version; \
	else \
		echo "$(GREEN)TFLint is already installed.$(RESET)"; \
		echo "$(YELLOW)TFLint version:$(RESET)"; \
		tflint --version; \
	fi

tfenv:
	@if ! command -v tfenv &> /dev/null; then \
		echo "$(YELLOW)Installing TFEnv...$(RESET)"; \
		git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv && \
		sudo ln -s ~/.tfenv/bin/* /usr/local/bin; \
		echo "$(GREEN)TFEnv installed successfully.$(RESET)"; \
		echo "$(YELLOW)TFEnv version:$(RESET)"; \
		tfenv --version; \
	else \
		echo "$(GREEN)TFEnv is already installed.$(RESET)"; \
		echo "$(YELLOW)TFEnv version:$(RESET)"; \
		tfenv --version; \
	fi

terraform-tools: terraform terragrunt tfsec tflint tfenv
	@echo "$(GREEN)All Terraform tools have been installed successfully.$(RESET)"

zsh-themes: powerlevel10k spaceship agnoster
	@echo "$(GREEN)Oh My Zsh themes installed successfully.$(RESET)"

powerlevel10k:
	@if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then \
		echo "$(YELLOW)Installing Powerlevel10k theme...$(RESET)"; \
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k; \
		echo "$(GREEN)Powerlevel10k installed successfully.$(RESET)"; \
		echo "$(YELLOW)To use Powerlevel10k, add 'ZSH_THEME=\"powerlevel10k/powerlevel10k\"' to your ~/.zshrc$(RESET)"; \
		echo "$(YELLOW)Then run 'source ~/.zshrc' and follow the configuration wizard$(RESET)"; \
	else \
		echo "$(GREEN)Powerlevel10k is already installed.$(RESET)"; \
	fi

spaceship:
	@if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt" ]; then \
		echo "$(YELLOW)Installing Spaceship theme...$(RESET)"; \
		git clone https://github.com/spaceship-prompt/spaceship-prompt.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt" --depth=1 && \
		ln -s "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"; \
		echo "$(GREEN)Spaceship installed successfully.$(RESET)"; \
		echo "$(YELLOW)To use Spaceship, add 'ZSH_THEME=\"spaceship\"' to your ~/.zshrc$(RESET)"; \
		echo "$(YELLOW)Then run 'source ~/.zshrc'$(RESET)"; \
	else \
		echo "$(GREEN)Spaceship is already installed.$(RESET)"; \
	fi

agnoster:
	@if [ ! -f "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/agnoster.zsh-theme" ]; then \
		echo "$(YELLOW)Installing Agnoster theme...$(RESET)"; \
		wget -O ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/agnoster.zsh-theme \
			https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme; \
		echo "$(GREEN)Agnoster installed successfully.$(RESET)"; \
		echo "$(YELLOW)To use Agnoster, add 'ZSH_THEME=\"agnoster\"' to your ~/.zshrc$(RESET)"; \
		echo "$(YELLOW)Then run 'source ~/.zshrc'$(RESET)"; \
	else \
		echo "$(GREEN)Agnoster is already installed.$(RESET)"; \
	fi

# Add fonts installation for better theme support
fonts:
	@echo "$(YELLOW)Installing Powerline fonts...$(RESET)"
	@if [ ! -d "fonts" ]; then \
		git clone --depth=1 https://github.com/powerline/fonts.git && \
		cd fonts && \
		./install.sh && \
		cd .. && \
		rm -rf fonts; \
	fi
	@echo "$(YELLOW)Installing Nerd Fonts...$(RESET)"
	@mkdir -p ~/.local/share/fonts
	@curl -fLo "Fira Code Regular Nerd Font Complete.ttf" \
		https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
	@mv "Fira Code Regular Nerd Font Complete.ttf" ~/.local/share/fonts/
	@fc-cache -f -v
	@echo "$(GREEN)Fonts installed successfully.$(RESET)"

flameshot:
	@if ! command -v flameshot &> /dev/null; then \
		echo "$(YELLOW)Installing Flameshot...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y flameshot; \
		echo "$(GREEN)Flameshot installed successfully.$(RESET)"; \
		echo "$(YELLOW)Launch with 'flameshot gui' or configure system shortcuts$(RESET)"; \
	else \
		echo "$(GREEN)Flameshot is already installed.$(RESET)"; \
	fi

gparted:
	@if ! command -v gparted &> /dev/null; then \
		echo "$(YELLOW)Installing GParted...$(RESET)"; \
		sudo apt-get update && \
		sudo apt-get install -y gparted; \
		echo "$(GREEN)GParted installed successfully.$(RESET)"; \
		echo "$(YELLOW)Launch GParted with 'sudo gparted' or from applications menu$(RESET)"; \
	else \
		echo "$(GREEN)GParted is already installed.$(RESET)"; \
	fi

