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
HAS_DOCKERCLI := $(shell command -v docker;)
HAS_ZSH := $(shell command -v zsh;)
HAS_PIP := $(shell command -v pip;)
HAS_CURL := $(shell command -v curl;)
HAS_VIM := $(shell command -v vim;)
HAS_EKSCTL := $(shell command -v eksctl;)
HAS_AWSCLI := $(shell command -v aws;)
HAS_KUBECTL := $(shell command -v kubectl;)
HAS_GCLOUD := $(shell command -v gcloud;)
HAS_AZURE := $(shell command -v az;)
HAS_MINIKUBE := $(shell command -v minikube;)
HAS_KIND := $(shell command -v kind;)
HAS_TERRAFORM := $(shell command -v terraform;)
HAS_ANSIBLE := $(shell command -v ansible;)
HAS_UNZIP := $(shell command -v unzip;)

.DEFAULT_GOAL := help

.PHONY: help prepare dockercli zsh PIP CURL VIM UNZIP EKSCTL AWSCLI KUBECTL GCLOUD AZURE MINIKUBE KIND TERRAFORM ANSIBLE install_all docker zsh pip curl vim unzip eksctl awscli kubectl gcloud azure minikube kind terraform ansible
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  DOCKERCLI           Check if docker is installed"
	@echo "  ZSH                 Check if zsh is installed"
	@echo "  PIP                 Check if pip is installed"
	@echo "  CURL                Check if curl is installed"
	@echo "  VIM                 Check if vim is installed"
	@echo "  UNZIP               Check if unzip is installed"
	@echo "  EKSCTL              Check if eksctl is installed"
	@echo "  AWSCLI              Check if awscli is installed"
	@echo "  KUBECTL             Check if kubectl is installed"
	@echo "  GCLOUD              Check if Google Cloud SDK is installed"
	@echo "  AZURE               Check if Azure CLI is installed"
	@echo "  MINIKUBE            Check if Minikube is installed"
	@echo "  KIND                Check if Kind is installed"
	@echo "  TERRAFORM           Check if Terraform is installed"
	@echo "  ANSIBLE             Check if Ansible is installed"

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
		sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl && \
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
		sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
		sudo apt-get update && sudo apt-get install terraform; \
	fi
	
	@if ! command -v ansible &> /dev/null; then \
		echo "$(YELLOW)Installing Ansible...$(RESET)"; \
		sudo apt update && \
		sudo apt install software-properties-common && \
		sudo add-apt-repository --yes --update ppa:ansible/ansible && \
		sudo apt install ansible; \
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

terraform:
	@if ! command -v terraform &> /dev/null; then \
		echo "$(YELLOW)Installing Terraform...$(RESET)"; \
		sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl && \
		wget -O- https://apt.releases.hashicorp.com/gpg | \
		gpg --dearmor | \
		sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
		sudo tee /etc/apt/sources.list.d/hashicorp.list && \
		sudo apt update && \
		sudo apt-get install terraform; \
		echo "$(GREEN)Terraform installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Terraform is already installed.$(RESET)"; \
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

