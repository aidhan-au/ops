# Install guide for new instances

Designed for Debian 11 - may work with previous versions and/or recent Ubuntu releases

Update and get basic packages

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git build-essential zip mosh wget curl nano ufw ca-certificates gnupg gnupg2 lsb-release debian-archive-keyring snapd && sudo snap install core
```

Add a user

```bash
adduser aidhan && adduser aidhan sudo

mkdir /home/aidhan/.ssh && \
wget -O - https://raw.githubusercontent.com/aidhan-creative/ops/main/id_rsa.pub > /home/aidhan/.ssh/authorized_keys

sudo chmod 700 /home/aidhan/.ssh && sudo chmod 600 /home/aidhan/.ssh/authorized_keys
sudo chown -R aidhan:aidhan /home/aidhan/.ssh && sudo systemctl restart sshd
```

Remove old users

```bash
sudo deluser --remove-home --remove-all-files debian
```

Do basic security (firewall up, disable root login, force key auth) - run as root

```bash
ufw disable && ufw reset
ufw allow 22 && ufw enable

wget -O - https://raw.githubusercontent.com/aidhan-creative/ops/main/setup/sshd_config > /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.d/* && systemctl restart ssh
```

Install GitHub CLI

```bash
sudo mkdir -m 0755 -p /etc/apt/keyrings; \
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/github-cli.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/github-cli.gpg] \
https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update && sudo apt install -y gh
```

Install Docker

```bash
sudo mkdir -m 0755 -p /etc/apt/keyrings; \
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Install nginx

```bash
sudo mkdir -m 0755 -p /etc/apt/keyrings; \
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor -o /etc/apt/keyrings/nginx.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/nginx.gpg] \
http://nginx.org/packages/debian $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null

sudo apt update && sudo apt install -y nginx
```
