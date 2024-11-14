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

.DEFAULT_GOAL := help

.PHONY: help prepare dockercli zsh PIP CURL VIM UNZIP EKSCTL AWSCLI KUBECTL GCLOUD AZURE MINIKUBE KIND TERRAFORM ANSIBLE install_all docker zsh pip curl vim unzip eksctl awscli kubectl gcloud azure minikube kind terraform ansible python3 java node npm codeclimate helm glasscube mysql mariadb postgres redis mongodb go thanos chef puppet nginx apache
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
	@echo "  CODECLIMATE         Check if CodeClimate is installed"
	@echo "  HELM                Check if Helm is installed"
	@echo "  GLASSCUBE           Check if Glasscube is installed"
	@echo "  MYSQL               Check if MySQL is installed"
	@echo "  MARIADB             Check if MariaDB is installed"
	@echo "  POSTGRES            Check if PostgreSQL is installed"
	@echo "  REDIS               Check if Redis is installed"
	@echo "  MONGODB             Check if MongoDB is installed"
	@echo "  GO                  Check if Go is installed"
	@echo "  THANOS              Check if Thanos is installed"
	@echo "  CHEF                Check if Chef is installed"
	@echo "  PUPPET              Check if Puppet is installed"
	@echo "  NGINX               Check if Nginx is installed"
	@echo "  APACHE              Check if Apache is installed"

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

codeclimate:
	@if ! command -v codeclimate &> /dev/null; then \
		echo "$(YELLOW)Installing CodeClimate...$(RESET)"; \
		curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz && \
		cd codeclimate-master && \
		sudo make install && \
		cd .. && rm -rf codeclimate-master && \
		sudo codeclimate engines:install; \
		echo "$(GREEN)CodeClimate installed successfully.$(RESET)"; \
		echo "$(YELLOW)Run 'codeclimate help' for usage information$(RESET)"; \
	else \
		echo "$(GREEN)CodeClimate is already installed.$(RESET)"; \
	fi

helm:
	@if ! command -v helm &> /dev/null; then \
		echo "$(YELLOW)Installing Helm...$(RESET)"; \
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null && \
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
		sudo apt-get update && \
		sudo apt-get install -y helm; \
		echo "$(GREEN)Helm installed successfully.$(RESET)"; \
		echo "$(YELLOW)Helm version:$(RESET)"; \
		helm version; \
	else \
		echo "$(GREEN)Helm is already installed.$(RESET)"; \
		echo "$(YELLOW)Helm version:$(RESET)"; \
		helm version; \
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

