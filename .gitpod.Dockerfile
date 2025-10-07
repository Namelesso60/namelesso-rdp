# Installer VS Code Desktop
RUN wget -qO- https://update.code.visualstudio.com/latest/linux-deb-x64/stable | sudo dpkg -i /dev/stdin || sudo apt-get install -f -y
