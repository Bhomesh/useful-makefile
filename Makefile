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

.DEFAULT_GOAL := help

.PHONY: help prepare dockercli zsh PIP CURL VIM UNZIP EKSCTL AWSCLI KUBECTL GCLOUD AZURE MINIKUBE KIND TERRAFORM ANSIBLE install_all docker zsh pip curl vim unzip eksctl awscli kubectl gcloud azure minikube kind terraform ansible python3 java node npm
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  DOCKER           	 Check if docker is installed"
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
	@echo "  PYTHON3             Check if Python3 is installed"
	@echo "  NVM                 Check if Node Version Manager is installed"
	@echo "  KUBEADM             Check if Kubeadm is installed"
	@echo "  PROMETHEUS          Check if Prometheus is installed"
	@echo "  GRAFANA             Check if Grafana is installed"
	@echo "  SONARQUBE           Check if SonarQube is installed"
	@echo "  JENKINS             Check if Jenkins is installed"
	@echo "  JAVA                Check if Java (JDK/JVM) is installed"
	@echo "  NODE                Check if Node.js is installed"
	@echo "  NPM                 Check if NPM is installed"

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
		echo "$(GREEN)Node.js installed successfully.$(RESET)"; \
		echo "$(YELLOW)Node.js version:$(RESET)"; \
		node --version; \
	else \
		echo "$(GREEN)Node.js is already installed.$(RESET)"; \
		echo "$(YELLOW)Node.js version:$(RESET)"; \
		node --version; \
	fi

npm:
	@if ! command -v npm &> /dev/null; then \
		echo "$(YELLOW)Installing NPM...$(RESET)"; \
		sudo apt-get install -y npm; \
		echo "$(GREEN)NPM installed successfully.$(RESET)"; \
		echo "$(YELLOW)NPM version:$(RESET)"; \
		npm --version; \
	else \
		echo "$(GREEN)NPM is already installed.$(RESET)"; \
		echo "$(YELLOW)NPM version:$(RESET)"; \
		npm --version; \
	fi

