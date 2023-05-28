sudo apt update && \
sudo apt install -y git curl ca-certificates gnupg gnupg2 lsb-release debian-archive-keyring && \

git config --global pull.rebase false; \
git config --global user.name "Aidhan Dossel"; \
git config --global user.email "me@aidhan.net"; \

sudo mkdir -m 0755 -p /etc/apt/keyrings; \
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/github-cli.gpg  && \

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/github-cli.gpg] \
https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \

sudo apt update && \
sudo apt install -y gh && \

gh auth login -p https -w && \
gh auth setup-git