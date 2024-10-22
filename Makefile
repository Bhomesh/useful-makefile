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
HAS_GIT := $(shell command -v git;)
HAS_PIP := $(shell command -v pip;)
HAS_CURL := $(shell command -v curl;)
HAS_NODE := $(shell command -v node;)
HAS_NPM := $(shell command -v npm;)
HAS_YARN := $(shell command -v yarn;)
HAS_VIM := $(shell command -v vim;)
HAS_EKSCTL := $(shell command -v eksctl;)
HAS_AWSCLI := $(shell command -v aws;)
HAS_KUBECTL := $(shell command -v kubectl;)

.DEFAULT_GOAL := help

.PHONY: help prepare dockercli zsh GIT PIP CURL NODE NPM YARN VIM EKSCTL AWSCLI KUBECTL install_all docker zsh git pip curl node nvm npm yarn vim eksctl awscli kubectl
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  DOCKERCLI           Check if docker is installed"
	@echo "  ZSH                 Check if zsh is installed"
	@echo "  GIT                 Check if git is installed"
	@echo "  PIP                 Check if pip is installed"
	@echo "  CURL                Check if curl is installed"
	@echo "  NODE                Check if node is installed"
	@echo "  NVM                 Check if nvm is installed"
	@echo "  NPM                 Check if npm is installed"
	@echo "  YARN                Check if yarn is installed"
	@echo "  VIM                 Check if vim is installed"
	@echo "  EKSCTL              Check if eksctl is installed"
	@echo "  AWSCLI              Check if awscli is installed"
	@echo "  KUBECTL             Check if kubectl is installed"

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
	
	@if ! command -v git &> /dev/null; then \
		echo "$(YELLOW)Installing Git...$(RESET)"; \
		sudo apt-get install -y git; \
	fi
	
	@if ! command -v pip &> /dev/null; then \
		echo "$(YELLOW)Installing Pip...$(RESET)"; \
		sudo apt-get install -y python3-pip; \
	fi
	
	@if ! command -v curl &> /dev/null; then \
		echo "$(YELLOW)Installing Curl...$(RESET)"; \
		sudo apt-get install -y curl; \
	fi
	
	@if ! command -v node &> /dev/null; then \
		echo "$(YELLOW)Installing Node.js...$(RESET)"; \
		curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
		sudo apt-get install -y nodejs; \
	fi
	
	@if ! command -v nvm &> /dev/null; then \
		echo "$(YELLOW)Installing NVM...$(RESET)"; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash; \
	fi
	
	@if ! command -v npm &> /dev/null; then \
		echo "$(YELLOW)Installing NPM...$(RESET)"; \
		sudo apt-get install -y npm; \
	fi
	
	@if ! command -v yarn &> /dev/null; then \
		echo "$(YELLOW)Installing Yarn...$(RESET)"; \
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
		sudo apt-get update && sudo apt-get install -y yarn; \
	fi
	
	@if ! command -v vim &> /dev/null; then \
		echo "$(YELLOW)Installing Vim...$(RESET)"; \
		sudo apt-get install -y vim; \
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

git:
	@if ! command -v git &> /dev/null; then \
		echo "$(YELLOW)Installing Git...$(RESET)"; \
		sudo apt-get install -y git; \
		echo "$(GREEN)Git installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Git is already installed.$(RESET)"; \
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

node:
	@if ! command -v node &> /dev/null; then \
		echo "$(YELLOW)Installing Node.js...$(RESET)"; \
		curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
		sudo apt-get install -y nodejs; \
		echo "$(GREEN)Node.js installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Node.js is already installed.$(RESET)"; \
	fi

nvm:
	@if ! command -v nvm &> /dev/null; then \
		echo "$(YELLOW)Installing NVM...$(RESET)"; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash; \
		echo "$(GREEN)NVM installed successfully. Please restart your terminal or run 'source ~/.bashrc' to use NVM.$(RESET)"; \
	else \
		echo "$(GREEN)NVM is already installed.$(RESET)"; \
	fi

npm:
	@if ! command -v npm &> /dev/null; then \
		echo "$(YELLOW)Installing NPM...$(RESET)"; \
		sudo apt-get install -y npm; \
		echo "$(GREEN)NPM installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)NPM is already installed.$(RESET)"; \
	fi

yarn:
	@if ! command -v yarn &> /dev/null; then \
		echo "$(YELLOW)Installing Yarn...$(RESET)"; \
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
		sudo apt-get update && sudo apt-get install -y yarn; \
		echo "$(GREEN)Yarn installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Yarn is already installed.$(RESET)"; \
	fi

vim:
	@if ! command -v vim &> /dev/null; then \
		echo "$(YELLOW)Installing Vim...$(RESET)"; \
		sudo apt-get install -y vim; \
		echo "$(GREEN)Vim installed successfully.$(RESET)"; \
	else \
		echo "$(GREEN)Vim is already installed.$(RESET)"; \
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
