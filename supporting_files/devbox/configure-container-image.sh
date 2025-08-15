#!/bin/sh

apt-get update
apt-get install -y sudo fish git ca-certificates curl gnupg build-essential procps file

### User Config ###
groupadd sudonp
useradd -ms /bin/fish -G sudo,sudonp -u 502 wtaylor

echo "%sudonp ALL = (ALL) NOPASSWD: ALL" >>/etc/sudoers

### Install docker-cli
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" >/etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y docker-ce-cli

### Install homebrew ###
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
chown -R wtaylor /home/linuxbrew/.linuxbrew

### Install wezterm ###
apt-get update
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
apt-get update
apt-get install -y wezterm
